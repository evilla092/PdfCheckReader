require "aws-sdk-s3"
require "aws-sdk-textract"
require "json"

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
    # @parsed_results = parse_data(results)
  end

  private

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
    response.to_h
    # detected_text = response.blocks.map(&:text)
    # detected_text.join("\n")

  end

  def parse_data(data)
    parsed_data = JSON.parse(data)
    parsed_string = ""

    parsed_data.each do |key, value|
      parsed_string << "Key: #{key}\n"

      if value.is_a?(Hash)
        parsed_string << "Value: (Hash)\n"
        value.each do |nested_key, nested_value|
          parsed_string << "  Nested Key: #{nested_key}, Nested Value: #{nested_value}\n"
        end
      elsif value.is_a?(Array)
        parsed_string << "Value: (Array)\n"
        value.each_with_index do |element, index|
          parsed_string << "  Element #{index}: #{element}\n"
        end
      else
        parsed_string << "Value: #{value}\n"
      end

      parsed_string << "--------------------------\n"
    end

    parsed_string
  end
end
