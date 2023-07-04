require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Shariasource
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # added back after Rails 6.0 upgrade
    config.action_dispatch.default_headers = {
      'X-Frame-Options' => 'ALLOWALL'
    }
    
    #config.assets.paths.concat(
    #  Compass::Frameworks::ALL.map { |f| f.stylesheets_directory }
    #)
    config.active_job.queue_adapter = :sidekiq
    config.autoload_paths << Rails.root.join('lib')
    # end add back
  end
end
