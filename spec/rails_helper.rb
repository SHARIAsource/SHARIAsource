ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

require 'rest-client'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include Devise::TestHelpers, :type => :controller
  config.include Devise::Test::ControllerHelpers, :type => :controller
  config.include Features::SessionHelpers, :type => :feature
  config.include Features::CorpusbuilderHelpers, :type => :feature
  config.include Features::InteractionHelpers, :type => :feature

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.before(:each) do
    User.delete_all
    Document.delete_all
    DocumentType.delete_all
    Language.delete_all
  end

  config.before(:each, type: :feature, js: true) do
    RestClient.post "#{ENV['CORPUS_BUILDER_API_URL']}/api/tests/clean", {}
    RestClient.post "#{ENV['CORPUS_BUILDER_API_URL']}/api/tests/prepare", {}
  end

  config.after(:each, type: :feature, js: true) do
    errors = page.driver.browser.manage.logs.get(:browser)
    if errors.present?
      aggregate_failures 'javascript errors' do
        errors.each do |error|
          expect(error.level).not_to eq('SEVERE'), error.message
          next unless error.level == 'WARNING'
          STDERR.puts 'WARN: javascript warning'
          STDERR.puts error.message
        end
      end
    end
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
