# app/jobs/process_task_job.rb
class ProcessTaskJob < ApplicationJob
  queue_as :default
  
  # Agregamos un callback para ver cuándo se encola
  after_enqueue do |job|
    Rails.logger.info "📬 JOB ENCOLADO: #{job.job_id}"
    Rails.logger.info "📦 Adaptador actual: #{Rails.application.config.active_job.queue_adapter}"
  end
  
  def perform(task_id, sleep_time = 5)
    # Veamos información del contexto de ejecución
    Rails.logger.info "🏃 EJECUTANDO EN: #{self.class.queue_adapter.class}"
    Rails.logger.info "🔧 Job ID: #{self.job_id}"
    
    task = Task.find(task_id)
    
    puts "=" * 50
    puts "🚀 INICIANDO JOB - Thread ID: #{Thread.current.object_id}"
    puts "📋 Procesando tarea: #{task.name}"
    puts "⏱️  Simulando trabajo pesado por #{sleep_time} segundos..."
    puts "=" * 50
    
    task.update!(status: 'processing')
    sleep(sleep_time)
    task.update!(status: 'completed', processing_time: sleep_time)
    
    puts "✅ TAREA COMPLETADA: #{task.name}"
  end
end