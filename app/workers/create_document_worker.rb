class CreateDocumentWorker
  include Sidekiq::Worker

  def perform(document_id)
    document = Document.find document_id
    api = Corpusbuilder::Ruby::Api.new
    api.create_document(document)
  end
end
