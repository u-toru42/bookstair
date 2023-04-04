# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + "/environment")
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

# stagingのみで実行
if rails_env.to_sym != :development
  # clear cache
  every 10.minutes do
    begin
      rake 'sample_task:all', :environment_variable => "RAILS_ENV", :environment => "development"
    rescue => e
      Rails.logger.error("aborted rake task")
      raise e
    end
  end
end

# 毎日5時01分と17時01分にジョブを実行する
every '1 5,17 * * *' do
  runner "FetchFeedsJob.perform_now", ENV['FEED_URLS'] || ''
end

# 毎週月曜日にジョブを実行する
every '0 0 * * 1' do
  runner "UpdateFeedsJob.perform_now"
end