class RegenerateImageWorker
  include Sidekiq::Worker

  def perform(doc_ids)
    Document.find(doc_ids).each_with_index do |document, idx|
      document.pages.destroy_all
      document.extract_pages :hybrid
      document.update! processed: true
      Rails.logger.info "Regenerated images for document with id #{document.id}"
      Rails.logger.info "Completed #{idx+1} of #{doc_ids.size}"
    end
  end
end
