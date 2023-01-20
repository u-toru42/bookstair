class BooksController < ApplicationController
  
  def new
    @book = Book.new
  end
  
  def create
    # binding.pry
    @book = Book.create(params.permit(:title, :author, :sales_date, :large_image_url, :item_url, :isbn))
    # @book.save!
    redirect_to books_path, notice: "#{@book[:title]}を保存しました。"
  end
  
  def index
    @books = Book.all
  end

  def search
    if params[:title_search].nil? && params[:author_search].nil?
      return
    elsif params[:title_search].blank? && params[:author_search].blank?
      flash.now[:danger] = '検索キーワードが入力されていません'
      return
    elsif params[:title_search] && (params[:author_search].nil? || params[:author_search].blank?)
      @books = RakutenWebService::Books::Book.search(title: params[:title_search])
    elsif params[:author_search] && (params[:title_search].nil? || params[:title_search].blank?)
      @books = RakutenWebService::Books::Book.search(author: params[:author_search])
    elsif params[:author_search] && params[:title_search]
      @books = RakutenWebService::Books::Book.search(title: params[:title_search], author: params[:author_search])
    end
  end

  private  

  def book_params
    params.require(:book).permit(:title, :sales_date, :large_image_url, :item_url, :isbn)
  end

  def author_params
    params.require(:book).permit(author: [])
  end

  def read(result)
    title = result["title"]
    author = result["author"]
    item_url = result["itemUrl"]
    isbn = result["isbn"]
    image_url = result["largeImageUrl"].gsub('?_ex=200x200', '')
    item_caption = result["itemCaption"]
    {
      title: title,
      author: author,
      url: url,
      isbn: isbn,
      image_url: image_url,
      item_caption: item_caption,
    }
  end
  
end