ENV["RACK_ENV"]             = "test"

require "rspec"
require "sequel"
require "database_cleaner"

require "mock_redis"
REDIS = MockRedis.new

require "./app"
def app
  AwesomeAPI
end

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    allow(REDIS).to receive(:publish).and_return(0)
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
