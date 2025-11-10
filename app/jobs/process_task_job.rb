# A job to process a task.
class ProcessTaskJob < ApplicationJob
  queue_as :default
  
  # Logs a message after the job is enqueued.
  #
  # @param job [ActiveJob::Base] The job that was enqueued.
  # @return [void]
  after_enqueue do |job|
    Rails.logger.info "📬 JOB ENQUEUED: #{job.job_id}"
    Rails.logger.info "📦 Current adapter: #{Rails.application.config.active_job.queue_adapter}"
  end
  
  # Executes the task processing job.
  #
  # @param task_id [Integer] The ID of the task to process.
  # @param sleep_time [Integer] The number of seconds to sleep to simulate a long-running task.
  def perform(task_id, sleep_time = 5)
    # Let's see information about the execution context
    Rails.logger.info "🏃 RUNNING IN: #{self.class.queue_adapter.class}"
    Rails.logger.info "🔧 Job ID: #{self.job_id}"
    
    task = Task.find(task_id)
    
    puts "=" * 50
    puts "🚀 STARTING JOB - Thread ID: #{Thread.current.object_id}"
    puts "📋 Processing task: #{task.name}"
    puts "⏱️  Simulating heavy work for #{sleep_time} seconds..."
    puts "=" * 50
    
    task.update!(status: 'processing')
    sleep(sleep_time)
    task.update!(status: 'completed', processing_time: sleep_time)
    
    puts "✅ TASK COMPLETED: #{task.name}"
  end
end