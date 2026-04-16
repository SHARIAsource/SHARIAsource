class RegeneratePdfWorker
  include Sidekiq::Worker

  def perform(document_id, with_text = false)
    document = Document.find_by_id(document_id)
    return unless document
    document.regenerate_pdf(with_text)
  end
end
