# Controller for managing tasks.
class TasksController < ApplicationController
  # Displays a list of all tasks, ordered by creation date.
  #
  # @return [void]
  def index
    @tasks = Task.order(created_at: :desc)
  end
  
  # Creates a new task and processes it synchronously.
  # This method will block the request for 5 seconds to simulate a long-running task.
  #
  # @return [void]
  def create_sync
    # SYNCHRONOUS processing (blocks the request)
    start_time = Time.current
    
    task = Task.create!(name: "Synchronous Task - #{Time.current}", status: 'pending')
    
    # This will block the browser
    sleep(5)
    task.update!(status: 'completed', processing_time: 5)
    
    flash[:notice] = "Task processed synchronously in #{(Time.current - start_time).round(2)} seconds"
    redirect_to tasks_path
  end
  
  # Creates a new task and processes it asynchronously using a background job.
  # This method will not block the request.
  #
  # @return [void]
  def create_async
    # ASYNCHRONOUS processing (doesn't block)
    start_time = Time.current
    
    task = Task.create!(name: "Asynchronous Task - #{Time.current}", status: 'pending')
    
    # This will NOT block the browser
    ProcessTaskJob.perform_later(task.id, 5)
    
    flash[:notice] = "Task enqueued in #{(Time.current - start_time).round(2)} seconds"
    redirect_to tasks_path
  end
end