require "sinatra"
require "json"
require "./db/setup"
require 'sidekiq'
require 'sidekiq/api'
require_relative 'workers/tick_worker.rb'

class AwesomeAPI < Sinatra::Base
  get '/' do
    stats = Sidekiq::Stats.new
    workers = Sidekiq::Workers.new
    "
    <p>Processed: #{stats.processed}</p>
    <p>In Progress: #{workers.size}</p>
    <p>Enqueued: #{stats.enqueued}</p>
    <p><a href='/'>Refresh</a></p>
    "
  end

  get "/ticks" do
    "<p>Ticks: #{Tick.count}</p>"
  end

  post '/ticks' do
    TickWorker.perform_async(10)
  end
end
