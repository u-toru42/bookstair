class FeedsController < ApplicationController
  def index
    @feeds = Feed.all.order(published_at: :desc)
  end
end
