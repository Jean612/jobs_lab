# En app/jobs/slow_job.rb
class SlowJob < ApplicationJob
  queue_as :low  # Cola de baja prioridad
  
  def perform(number)
    Rails.logger.info "🐌 Job lento ##{number} iniciando..."
    sleep(10)  # Tarda 10 segundos
    Rails.logger.info "🐌 Job lento ##{number} terminado!"
  end
end