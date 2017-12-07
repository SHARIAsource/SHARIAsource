class PollDocumentWorker
  include Sidekiq::Worker

  def perform(document_id, sharia_source_doc_id)
    ocr_state = Document.find(sharia_source_doc_id).ocr_state
    ocr_state.polling_document_status!

    begin
      api = Corpusbuilder::Ruby::Api.new
      response = api.get_document_status(document_id)
      if response["status"] === "initial"
        PollDocumentWorker.perform_in(1.minute, document_id, sharia_source_doc_id)
      elsif response["status"] === "error"
        ocr_state.set_error_message(response)
        Rails.logger.info "Document #{document_id} failed to be processed by Corpusbuilder: #{response}"
      else
        #do something wih new document
        ocr_state.update_attributes(state: :complete, status: :ready)
      end
    rescue Exception => e
      minutes_til_resend = 1
      ocr_state.set_error_message(e)

      Rails.logger.error "Error polling Corpusbuilder for document status: #{e}, polling again in #{minutes_til_resend} minute"
      PollDocumentWorker.perform_in(minutes_til_resend.minute, document_id, sharia_source_doc_id)
    end
  end
end
