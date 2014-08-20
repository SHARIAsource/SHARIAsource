class PopularityWorker
  include Sidekiq::Worker

  def perform(id, action)
    Document.find(id).public_send(action.to_sym, :popular_count)
  end
end
