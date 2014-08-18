class PopularityWorker
  include Sidekiq::Worker

  def perform(klass, id, action)
    klass.constantize.find(id).public_send(action.to_sym, :popular_count)
  end
end
