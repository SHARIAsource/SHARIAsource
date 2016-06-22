class RegenerateImageWorker
  include Sidekiq::Worker

  def perform doc_ids
    documents = Document.find(doc_ids)
    documents.each { |doc| doc.update! processed: false } unless documents.blank?
    processing = false
    current = doc_ids.pop
    while !doc_ids.blank?
      if processing
        if Document.find(current).processed
          Rails.logger.info "Regenerated images for document with id #{current},
                             #{doc_ids.size} documents to go!"
          processing = false
          current = doc_ids.pop
        else
          sleep(5)
        end
      else
        PdfToImagesWorker.perform_async(current)
        processing = true
      end
    end
  end

end
