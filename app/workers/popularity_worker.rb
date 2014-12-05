class PopularityWorker
  include Sidekiq::Worker

  def perform(id, action)
    document = Document.find_by_id id
    if document
      document.public_send(action.to_sym, :popular_count)
    end
  end
end
