class PdfToImagesWorker
#  include Sidekiq::Worker

  def perform(document_id, with_text=false)
    document = Document.find document_id
    document.regenerate_pdf(with_text)
  end
end
