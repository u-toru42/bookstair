require_relative "config/environment"

rails_env = ENV['RAILS_ENV'] || :development

set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"

every 15.minutes do
  runner "FetchFeedsJob.perform_now", ENV['FEED_URLS'] || ''
end

every :hour do
  every :hour, at: '00:00' do
    runner "UpdateFeedsJob.perform_now"
  end
end
