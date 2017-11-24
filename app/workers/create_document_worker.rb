class CreateDocumentWorker
  include Sidekiq::Worker

  def perform(image_ids, document_id)
    begin
      api = Corpusbuilder::Ruby::Api.new
      document = Document.find document_id
      response = api.create_document({:images => image_ids, :metadata => document.to_json, :editor_email => document.user.email})
      PollDocumentWorker.perform_async(response["id"], document_id)
    rescue Exception => e
      Rails.logger.error "Error creating Corpusbuilder document: #{e}"
    end
  end
end
