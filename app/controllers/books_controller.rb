class BooksController < ApplicationController
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.create(params.permit(:title, :author, :sales_date, :large_image_url, :item_url, :isbn, :item_price, :item_caption))
    if @book.valid?
      redirect_to books_path, notice: "「#{@book[:title]}」を保存しました。"
    else
      redirect_to books_path, notice: "「#{@book[:title]}」は既に保存されています。"
    end
  end

  def destroy
    # button_toのvalueがidになっているがisbnに変換することは可能か
    book = Book.find_by(isbn: params[:isbn])
    book.delete
    redirect_to books_path, danger: "「#{book[:title]}」を削除しました。", status: :see_other
  end
  
  def index
    @books = Book.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def search
    if params[:title_search].nil? && params[:author_search].nil?
      return
    elsif params[:title_search].blank? && params[:author_search].blank?
      flash.now.notice = '検索キーワードが入力されていません'
      return
    elsif params[:title_search] && (params[:author_search].nil? || params[:author_search].blank?)
      @books = RakutenWebService::Books::Book.search(title: params[:title_search], booksGenreId: "001005")
    elsif params[:author_search] && (params[:title_search].nil? || params[:title_search].blank?)
      @books = RakutenWebService::Books::Book.search(author: params[:author_search], booksGenreId: "001005")
    elsif params[:author_search] && params[:title_search]
      @books = RakutenWebService::Books::Book.search(title: params[:title_search], author: params[:author_search], booksGenreId: "001005")
    end
  end

  def show
    @book = Book.find_by!(isbn: params[:isbn])
    @bookmark = Bookmark.new
    @bookmarks = @book.bookmarks.includes(:user).order(created_at: :desc)
    if params[:tag_ids]
      @bookmarks = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_bookmarks = Tag.find_by(name: key).bookmarks
          @bookmarks = @bookmarks.empty? ? tag_bookmarks : @bookmarks & tag_bookmarks
        end
      end
    end
    if params[:tag].blank?
      return
    else
      Tag.create(name: params[:tag])
    end
  end

  private  

  def book_params
    params.require(:book).permit(:title, :sales_date, :large_image_url, :item_url, :isbn, :item_price, :item_caption)
  end

  def author_params
    params.require(:book).permit(author: [])
  end

end