class FeedsController < ApplicationController
  def index
    # ニュースフィード(未完成)
    @feeds = Feed.all.order(updated_at: :asc)
    @show_feeds = true
  end
end
