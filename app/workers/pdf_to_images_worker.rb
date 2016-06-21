class PdfToImagesWorker
  include Sidekiq::Worker

  def perform(source_id, method)
    source = Document.find source_id
    source.pages.destroy_all
    source.extract_pages method.to_sym
    source.update! processed: true
  end
end
