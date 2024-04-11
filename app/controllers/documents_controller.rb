require "aws-sdk-s3"
require "aws-sdk-textract"
require "json"
require 'httparty'

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
    document = params[:s3_name]
    bucket = "textract-console-us-east-2-4b222d35-ecba-47d6-8c8c-ca0b8742fcf2"
    @results = get_results(document, bucket)
    @results = process_lines(@results).to_s
    new_hash = hash_from_gpt(@results)

    

    # @parsed_results = parse_data(results)
  end

  private

  def hash_from_gpt(prompt)
    api_key = ENV["OPEN_AI_KEY"] # Store your API key securely in environment 
    assistant_id = ENV['CHATGPT_ASSISTANT_ID']

    response = HTTParty.post(
      'https://api.openai.com/v1/completions',
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{api_key}"
      },
      body: {
        model: assistant_id, # Use the assistant ID as the model
        prompt: prompt,
        max_tokens: 100
      }.to_json
    )

    response.body
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
