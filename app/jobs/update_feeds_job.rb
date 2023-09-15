require 'faraday'
require 'feedjira'

class UpdateFeedsJob < ApplicationJob
  queue_as :default

  def perform
    # 今日の日付を取得
    today = Date.today

    # 毎日5時01分にフィードを更新
    Feed.update_from_feed_url! if Time.current.hour == 5 && Time.current.min == 1

    # 毎日17時01分に過去の記録を削除
    return unless Time.current.hour == 17 && Time.current.min == 1

    Feed.where('updated_at < ?', today).delete_all
  end
end
