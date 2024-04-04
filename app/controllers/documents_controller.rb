class DocumentsController < ApplicationController

  def create
    @document = Document.new(document_params)
    if @document.save
      document_url = url_for(@document.file)
      redirect_to document_path(@document), notice: 'Document was successfully uploaded.'
    else
      render root_path, alert: "issue"
    end

    def survey
    end
  end

  private

  def document_params
    params.require(:document).permit(:file)
  end

  def show
    @document = Document.find(params[:id])
  end

end
