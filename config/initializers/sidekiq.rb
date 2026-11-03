redis = { url: ENV['REDIS_URL'], password: ENV['REDIS_PASSWORD'] }

Sidekiq.configure_server do |config|
  config.redis = redis
  config.poll_interval = 15
  Rails.logger = Sidekiq::Logging.logger
end

Sidekiq.configure_client do |config|
  config.redis = redis
end
