class FeedsController < ApplicationController
  def index
    # ニュースフィード
    @feeds = Feed.all.order(updated_at: :asc)
    @show_feeds = true
  end
end
