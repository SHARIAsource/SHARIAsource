class PdfToImagesWorker
  include Sidekiq::Worker

  def perform(source_id, with_text=false)
    source = Document.find source_id
    source.pages.destroy_all
    source.extract_pages(with_text)
    source.update! processed: true
  end
end
