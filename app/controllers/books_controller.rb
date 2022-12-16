class BooksController < ApplicationController
  def bookmark
    @books = []
    @title = params[:title]
    if @title.present?
      results = RakutenWebServices::Books::Book.search({
        title: @title,
      })

      results.each do |result|
        book = Book.new(read(result))
        @books << book
      end
    end

    @books.each do |book|
      unless Book.all.include?(book)
        book.save
      end
    end
  end
  
  def index; end

  def search
    if params[:search].nil?
      return
    elsif params[:search].blank?
      flash.now[:danger] = '検索キーワードが入力されていません'
      return
    elsif params[:search]
      @books = RakutenWebService::Books::Book.search(title: params[:search])
    end
  end

  private

  def read(result)
    title = result['title']
    url = result['itemUrl']
    isbn = result['isbn']
    image_url = result['mediumImageUrl'].gsub('?_ex=112x162', '')
    {
      title: title,
      url: url,
      isbn: isbn,
      image_url: image_url,
    }
  end
end
