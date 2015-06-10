require "rspec"
require "capybara/rspec"
require "launchy"
require "database_cleaner"

require_relative "../server"

set :environment, :test

Capybara.app = Sinatra::Application
ActiveRecord::Base.logger.level = 1

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
