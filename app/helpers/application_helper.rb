module ApplicationHelper
  def set_rakuten_book_params(word)
    #volumeInfoの中が必要な項目のみになるようsliceを使って絞りこむ
    word.gsub(/(\s|　)+/, ' ').gsub("／", "/").tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')
  end

  def set_rakuten_book_author_params(word)
    word.gsub(/(\s|　)+/, ' ').gsub("／", "/").tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z').split("/")
  end
  
  def set_rakuten_page(word)
    word.delete("^0-9")
  end

  def page_title(page_title = '')
    base_title = 'BOOKSTAIR'

    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def qiita_tags
    conn = Faraday.new(url: 'https://qiita.com')
    response = conn.get '/api/v2/tags', { page: 1, per_page: 100 }
    tags = JSON.parse(response.body)
    tags.map { |tag| tag['name'] }
  end

  def default_meta_tags
    {
      site: 'BOOKSTAIR',
      title: 'IT・コンピュータの書籍好きに',
      reverse: true,
      separator: '|',
      description: 'BOOKSTAIRはIT・コンピュータの書籍の専門サービスです。',
      keywords: 'IT, コンピュータ, プログラミング',
      charset: 'UTF-8',
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: image_url('favicon.ico'),
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('og_image.png'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        image: image_url('og_image.png')
      }
    }
  end
end
