Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.credentials.redis[:url].to_s }
end

Sidekiq.configure_client do |config|
  config.redis = { url: Rails.application.credentials.redis[:url].to_s }
end

schedule_file = 'config/schedule.yml'

if File.exist?(schedule_file) && Sidekiq.server?
  Sidekiq::Scheduler.enabled = true
  Sidekiq::Scheduler.load_schedule! schedule_file
end
