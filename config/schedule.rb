# config/schedule.rb
# 毎日5時01分と17時01分にジョブを実行する
every '1 5,17 * * *' do
  runner "FetchFeedsJob.perform_now", ENV['FEED_URLS'] || ''
end

# 毎週月曜日にジョブを実行する
every '0 0 * * 1' do
  runner "UpdateFeedsJob.perform_now"
end