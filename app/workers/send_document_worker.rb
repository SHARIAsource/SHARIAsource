class SendDocumentWorker
  include Sidekiq::Worker

  def perform(document_id)
    document = Document.find document_id
    api = Corpusbuilder::Ruby::Api.new
    api.create_document(images:[], metadata: document)
  end
end
