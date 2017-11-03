class PollDocumentWorker
  include Sidekiq::Worker

  def perform(document_id)
    begin
      api = Corpusbuilder::Ruby::Api.new
      response = api.get_document_status(document_id)
      if response["status"] === "initial"
        PollDocumentWorker.perform_in(1.minute, document_id) if response["status"] === "initial"
      else
        #start next worker
      end
    rescue Exception => e
      Rails.logger.error "Error polling Corpusbuilder for document status: #{e}"
    end
  end
end
