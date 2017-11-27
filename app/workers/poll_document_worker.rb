class PollDocumentWorker
  include Sidekiq::Worker

  def perform(document_id, sharia_source_doc_id)
    begin
      api = Corpusbuilder::Ruby::Api.new
      response = api.get_document_status(document_id)
      Document.find(sharia_source_doc_id).update_attributes(cb_status: response["status"])
      if response["status"] === "initial"
        PollDocumentWorker.perform_in(1.minute, document_id, sharia_source_doc_id)
      elsif response["status"] === "error"
        Rails.logger.info "Document #{document_id} failed to be processed by Corpusbuilder: #{response}"
      else
        #start next worker
      end
    rescue Exception => e
      #Decide how long you want to wait before trying again
      minutes_til_resend = 1

      Rails.logger.error "Error polling Corpusbuilder for document status: #{e}, polling again in #{minutes_til_resend} minute"
      PollDocumentWorker.perform_in(minutes_til_resend.minute, document_id, sharia_source_doc_id)
    end
  end
end
