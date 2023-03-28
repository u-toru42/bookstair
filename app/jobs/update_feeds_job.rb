require 'faraday'
require 'feedjira'

class UpdateFeedsJob < ApplicationJob
  queue_as :default

  def perform
    # 今日の日付を取得
    today = Date.today

    # 毎日5時01分にフィードを更新
    if Time.current.hour == 5 && Time.current.min == 1
      Feed.update_from_feed_url!
    end

    # 毎日17時01分に過去の記録を削除
    if Time.current.hour == 17 && Time.current.min == 1
      Feed.where("updated_at < ?", today).delete_all
    end
  end
end
