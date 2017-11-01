class CreateDocumentWorker
  include Sidekiq::Worker

  def perform(image_ids, document_id)
    begin
      api = Corpusbuilder::Ruby::Api.new
      document = Document.find document_id
      api.create_document({:images => image_ids, :metadata => document.to_json, :editor_email => document.user.email})
    rescue Exception => e
      Rails.logger.error "Error creating Corpusbuilder document: #{image_ids}"
    end
  end
end
