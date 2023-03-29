# config/schedule.rb
# Rails.rootを使用するようにする（※wheneverはrailsの起動を前提とするため）
require File.expand_path(File.dirname(__FILE__) + "/environment")

# コンテナ起動時の環境変数をcron独自の環境変数にパス
ENV.each { |k, v| env(k, v) }

#出力先ログ
set :output, 'log/cron_monthly_batch.log'
#実行環境
set :environment, :development

# 毎日5時01分と17時01分にジョブを実行する
every '1 5,17 * * *' do
  runner "FetchFeedsJob.perform_now", ENV['FEED_URLS'] || ''
end

# 毎週月曜日にジョブを実行する
every '0 0 * * 1' do
  runner "UpdateFeedsJob.perform_now"
end