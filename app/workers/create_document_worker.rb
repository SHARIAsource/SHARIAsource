class CreateDocumentWorker
  include Sidekiq::Worker

  def perform(image_ids, document_id)
    document = Document.find(document_id)
    ocr_state = document.ocr_state
    ocr_state.sending_document!

    begin
      api = Corpusbuilder::Ruby::Api.new
      response = api.create_document({:images => image_ids, :metadata => document.to_json, :editor_email => document.user.email})
      cb_doc_id = response["id"]

      ocr_state.set_document_id(cb_doc_id)
      PollDocumentWorker.perform_async(cb_doc_id, document_id)
    rescue Exception => e
      ocr_state.set_error_message(e.response)
      Rails.logger.error "Error creating Corpusbuilder document: #{e}"
    end
  end
end
