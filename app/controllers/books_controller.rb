class BooksController < ApplicationController
  def create; end
  
  def index; end

  def show; end

  def search
    if params[:title_search].nil? && params[:author_search].nil?
      return
    elsif params[:title_search].blank? && params[:author_search].blank?
      flash.now[:danger] = '検索キーワードが入力されていません'
      return
    elsif params[:title_search] && (params[:author_search].nil? || params[:author_search].blank?)
      @books = RakutenWebService::Books::Book.search(title: params[:title_search])
      
      url = "https://app.rakuten.co.jp/services/api/BooksBook/Search"
      text = params[:title_search]
      res = Faraday.get(url, q: text, langRestrict: 'ja', maxResults: 20)
      @rakuten_books = JSON.parse(res.body)

    elsif params[:author_search] && (params[:title_search].nil? || params[:title_search].blank?)
      @books = RakutenWebService::Books::Book.search(author: params[:author_search])
      
      url = "https://app.rakuten.co.jp/services/api/BooksBook/Search"
      text = params[:author_search]
      res = Faraday.get(url, q: text, langRestrict: 'ja', maxResults: 20)
      @rakuten_books = JSON.parse(res.body)
    
    elsif params[:author_search] && params[:title_search]
      @books = RakutenWebService::Books::Book.search(title: params[:title_search], author: params[:author_search])

      url = "https://app.rakuten.co.jp/services/api/BooksBook/Search"
      text = params[:title_search] && params[:author_search]
        res = Faraday.get(url, q: text, langRestrict: 'ja', maxResults: 20)
      @rakuten_books = JSON.parse(res.body)
    end
  end

  private  

  def book_params
    params.require(:book).permit(:title, :author, :sales_date, :medium_image_url, :item_url, :isbn)
  end

  def authors_params
    params.require(:book).permit(authors: [])
  end
  
end