# A job that simulates a slow task.
class SlowJob < ApplicationJob
  queue_as :low  # Low priority queue
  
  # Executes the slow job.
  #
  # @param number [Integer] The number of the job.
  def perform(number)
    Rails.logger.info "🐌 Slow job ##{number} starting..."
    sleep(10)  # Takes 10 seconds
    Rails.logger.info "🐌 Slow job ##{number} finished!"
  end
end