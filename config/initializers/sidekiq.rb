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
