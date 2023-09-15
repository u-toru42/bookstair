namespace :rss do
  desc 'RSSを取得するタスク'
  task media_rss_get: [:environment] do
    Medium.all.each do |media|
      content = Feedjira::Feed.fetch_and_parse(media.rss_url)
      content.entries.each do |article|
        local_article = media.articles.where(title: article.title).first_or_initialize
        local_article.update_attributes(content: article.summary, author: article.author, url: article.url,
                                        published: article.published)
      end
    end
  end
end
