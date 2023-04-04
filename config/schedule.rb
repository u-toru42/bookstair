require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

set :environment, 'production'
set :output, "#{Rails.root}/log/cron.log"

every 15.minutes do
  runner "FetchFeedsJob.perform_now", ENV['FEED_URLS'] || '', :environment_variable => 'RAILS_ENV=production'
end

every :hour, :at => '0:00' do
  runner "UpdateFeedsJob.perform_now", :environment_variable => 'RAILS_ENV=production'
end
