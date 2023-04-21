require 'sidekiq/api'
require 'sidekiq-cron'

if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.on(:startup) do
      Sidekiq::Cron::Job.load_from_hash YAML.load_file(File.expand_path('../../../config/schedule.yml', __FILE__))
    end
  end
end

if Rails.env.development?
  Sidekiq.configure_server do |config|
    config.on(:startup) do
      Sidekiq::Cron::Job.load_from_hash YAML.load_file(File.expand_path('../../../config/schedule.yml', __FILE__))
    end
  end
end

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://127.0.0.1:6379' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://127.0.0.1:6379' }
end