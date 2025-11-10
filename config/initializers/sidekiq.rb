# Este archivo configura la conexión entre Rails y Redis
Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1') }
  
  # Esto te mostrará exactamente qué está pasando
  config.logger.level = Logger::DEBUG if Rails.env.development?
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1') }
end