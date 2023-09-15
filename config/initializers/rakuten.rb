RakutenWebService.configure do |c|
  # (必須) アプリケーションID
  c.application_id = Rails.application.credentials.rakuten[:application_id].to_s

  # (任意) 楽天アフィリエイトID
  # c.affiliate_id = Rails.application.credentials.rakuten[:affiliate_id]
end
