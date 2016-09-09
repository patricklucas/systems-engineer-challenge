require "./models/tick"
class TickWorker
  include Sidekiq::Worker
  def perform(sleep_time)
    sleep sleep_time
    Tick.create(ticks: Tick.count+1, updated_at: DateTime.now)
  end
end
