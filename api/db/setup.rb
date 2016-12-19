require "sequel"
require "aws-sdk"
require "redis"
require "sidekiq"

DB ||= if ENV["RACK_ENV"] == "test"
         Sequel.connect(ENV["TEST_DATABASE_URL"])
       elsif ENV.key?("RDS_HOSTNAME")
         Sequel.connect(
           "postgres://#{ENV['RDS_USERNAME']}:#{ENV['RDS_PASSWORD']}@"\
           "#{ENV['RDS_HOSTNAME']}:#{ENV['RDS_PORT']}/#{ENV['RDS_DB_NAME']}"
         )
       else
         Sequel.connect(ENV["DATABASE_URL"])
       end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_PUBLISH_URL"] }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_PUBLISH_URL"] }
end