ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'capybara/rspec'
require 'rspec/rails'
require 'shoulda/matchers'
require 'closure_tree/test/matcher'

HOST = `ip route| grep $(ip route |grep default | awk '{ print $5 }') | grep -v "default" | awk '/scope/ { print $9 }'`.gsub("\n", "")

RSpec.configure do |config|
  # The settings below are suggested to provide a good initial experience
  # with RSpec, but feel free to customize to your heart's content.

  # These two settings work together to allow you to limit a spec run
  # to individual examples or groups you care about by tagging them with
  # `:focus` metadata. When nothing is tagged with `:focus`, all examples
  # get run.
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  # config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed

  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # Enable only the newer, non-monkey-patching expect syntax.
    # For more details, see:
    #   - http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax
    expectations.syntax = :expect
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Enable only the newer, non-monkey-patching expect syntax.
    # For more details, see:
    #   - http://teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
    mocks.syntax = :expect

    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended.
    mocks.verify_partial_doubles = true
  end

  ActiveRecord::Migration.maintain_test_schema!

  config.use_transactional_fixtures = false
  config.include Capybara::DSL
  config.include FactoryBot::Syntax::Methods
  config.include ClosureTree::Test::Matcher

  browser_options = ::Selenium::WebDriver::Chrome::Options.new()
  browser_options.add_argument('no-sandbox')
  browser_options.add_argument('disable-gpu')

  Capybara.register_driver :chrome do |app|
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: {
        w3c: false,
      }
    )

    Capybara::Selenium::Driver.new(app,
      :browser => :chrome,
      :desired_capabilities => capabilities,
      :url => "http://selenium:4444/wd/hub",
      options: browser_options
    )
  end

  Capybara.register_server :concurrent_puma do |app, port, host|
    require 'rack/handler/puma'
    Rack::Handler::Puma.run(app, Host: host, Port: port, Threads: "4:8")
  end

  Capybara.server = :concurrent_puma
  Capybara.server_port = "3000"
  Capybara.server_host = HOST
  Capybara.app_host = "http://#{HOST}:3000"
  Capybara.run_server = true
  Capybara.threadsafe = true

  Capybara.javascript_driver = :chrome
end
