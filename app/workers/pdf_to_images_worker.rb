class PdfToImagesWorker
  include Sidekiq::Worker

  def perform(source_id)
    source = Document.find source_id
    source.pages.destroy_all
    source.extract_pages
    source.update! processed: true
  end
end
