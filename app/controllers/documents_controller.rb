require "aws-sdk-s3"
require "aws-sdk-textract"
require "json"
require "httparty"

class DocumentsController < ApplicationController
  def create
    @document = Document.new(document_params)
    if @document.save
      document_url = url_for(@document.file)
      redirect_to document_path(@document), notice: "Document was successfully uploaded."
    else
      render root_path, alert: "issue"
    end
  end

  def show
    @document = Document.find(params[:id]).file
    @s3_name = @document.blob.key.to_s
    @uni_var = "hello"
  end

  def loading
    @new_check = Check.new
    @new_check.employer_id = params[:employer_id]
    @new_check.user_id = current_user.id
    @new_check.check_date = Date.today
    @new_check.check_amount = 200.00
    @new_check.save
    document = params[:s3_name]
    bucket = "textract-console-us-east-2-4b222d35-ecba-47d6-8c8c-ca0b8742fcf2"
    @results = get_results(document, bucket)
    @results = process_lines(@results).to_s
    @new_hash = hash_from_gpt(@results).to_s
    @hash = JSON.parse(@new_hash).fetch("members")
    @hash.each do |record|
      new_payer = Payer.new
      new_payer.name = record.fetch("name")
      new_payer.dues_amount = record.fetch("dues_amount")
      new_payer.hourly_rate = record.fetch("hourly_rate")
      new_payer.check_id = @new_check.id
      new_payer.save
    
    end
    redirect_to payers_path
    

    # @parsed_results = parse_data(results)
  end

  def download_csv
    # Query the data from your model
    data = Payer.all

    # Generate the CSV file
    csv_data = generate_csv(data)

    # Send the CSV file as a download
    send_data csv_data, filename: 'data.csv', type: 'text/csv'
  end

  private

  def generate_csv(data)
    CSV.generate do |csv|
      # Write the header row
      csv << Payer.column_names

      # Write each record as a row in the CSV file
      data.find_each do |record|
        csv << record.attributes.values
      end
    end
  end

  def hash_from_gpt(string_array)
    prompt_file_path = Rails.root.join("app", "data", "prompt.txt")
    prompt = File.read(prompt_file_path).strip + string_array
    api_key = ENV["OPEN_AI_KEY"] # Store your API key securely in environment

    response = HTTParty.post(
      "https://api.openai.com/v1/chat/completions",
      headers: {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{api_key}",
      },
      body: {
        model: "gpt-4-turbo",
        messages: [
          {
            role: "system",
            content: "Prompt: " + prompt,
          },
        ],
        max_tokens: 1500, # Or any other value you prefer
        temperature: 0.7, # Control the randomness of the generated completions
      }.to_json,
    )

    result = JSON.parse(response.body).fetch("choices").at(0).fetch("message").fetch("content")
  
  end

  def document_params
    params.require(:document).permit(:file)
  end

  def get_results(document, bucket)
    client = Aws::Textract::Client.new(region: "us-east-2")
    request = {
      document: {
        s3_object: {
          name: document,
          bucket: bucket,
        },
      },

      feature_types: ["TABLES"],
    }
    response = client.analyze_document(request)
  end

  def parse_lines_from_textract_response(textract_response)
    textract_response[:blocks].each do |block|
      if block[:block_type] == "LINE"
        # Extract information from the line block
        text = block[:text]
        confidence = block[:confidence]
        # Process the extracted line information here
        yield(text, confidence) if block_given?
      end
    end
  end

  def process_lines(textract_response)
    text_results = Array.new
    parse_lines_from_textract_response(textract_response) do |text, confidence|
      # Process the extracted line information here
      text_results.push(text)
    end

    text_results
  end


end
