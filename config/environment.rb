# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
Corpusbuilder::Ruby::Api.config.api_url = "https://api.some.corpusbuilder.com"
Corpusbuilder::Ruby::Api.config.api_version = 1 
Corpusbuilder::Ruby::Api.config.app_id= 100 
Corpusbuilder::Ruby::Api.config.token = "a" 
