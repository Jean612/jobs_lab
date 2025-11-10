class TasksController < ApplicationController
  def index
    @tasks = Task.order(created_at: :desc)
  end
  
  def create_sync
    # Procesamiento SÍNCRONO (bloquea el request)
    start_time = Time.current
    
    task = Task.create!(name: "Tarea Síncrona - #{Time.current}", status: 'pending')
    
    # Esto bloqueará el navegador
    sleep(5)
    task.update!(status: 'completed', processing_time: 5)
    
    flash[:notice] = "Tarea procesada síncronamente en #{(Time.current - start_time).round(2)} segundos"
    redirect_to tasks_path
  end
  
  def create_async
    # Procesamiento ASÍNCRONO (no bloquea)
    start_time = Time.current
    
    task = Task.create!(name: "Tarea Asíncrona - #{Time.current}", status: 'pending')
    
    # Esto NO bloqueará el navegador
    ProcessTaskJob.perform_later(task.id, 5)
    
    flash[:notice] = "Tarea encolada en #{(Time.current - start_time).round(2)} segundos"
    redirect_to tasks_path
  end
end