class CreateDocumentWorker
  include Sidekiq::Worker

  def perform(image_ids, document_id)
    document = Document.find(document_id)
    ocr_state = document.ocr_state
    ocr_state.sending_document!

    begin
      api = Corpusbuilder::Ruby::Api.new
      response = api.create_document({:images => image_ids, :metadata => document.to_json, :editor_email => document.user.email})
      PollDocumentWorker.perform_async(response["id"], document_id)
    rescue Exception => e
      ocr_state.set_error_message(e)
      Rails.logger.error "Error creating Corpusbuilder document: #{e}"
    end
  end
end
