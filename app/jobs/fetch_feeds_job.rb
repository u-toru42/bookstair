require 'faraday'
require 'feedjira'

class FetchFeedsJob < ApplicationJob
  queue_as :default

  DEFAULT_URLS = [
    "https://b.hatena.ne.jp/hotentry/it.rss",
    "https://gihyo.jp/dev/feed/rss2"
  ]

  def perform(*urls)
    urls = DEFAULT_URLS + urls.flatten.compact
    urls.each do |url|
      conn = Faraday.new(url: url)
      response = conn.get
      xml = response.body
      Feedjira.parse(xml).entries.each do |entry|
        Feed.create(
          title: entry.title,
          url: entry.url,
          content: entry.content
        )
      end
    end
  end
end