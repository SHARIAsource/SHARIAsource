Sidekiq.configure_server do |config|
  config.poll_interval = 15
  Rails.logger = Sidekiq::Logging.logger
end
