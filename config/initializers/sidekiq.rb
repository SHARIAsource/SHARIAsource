redis = { url: ENV['REDIS_URL'], password: ENV['REDIS_PASSWORD'] }

Sidekiq.configure_server do |config|
  config.redis = redis
  config.poll_interval = 15
  Rails.logger = Sidekiq::Logging.logger

  # Heartbeat for the container health check: touch a file every 30 seconds
  # while the process is up. On when SIDEKIQ_HEARTBEAT_FILE is set.
  # ponytail: proves the process is alive, not that jobs are being worked.
  if (heartbeat = ENV['SIDEKIQ_HEARTBEAT_FILE'])
    config.on(:startup) do
      Thread.new do
        loop do
          FileUtils.touch(heartbeat)
          sleep 30
        end
      end
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = redis
end
