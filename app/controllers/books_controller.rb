class BooksController < ApplicationController
  before_action :move_to_signed_in

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
    # @books = Book.all.order(created_at: :desc)
    @search = Book.ransack(params[:q])

    @search.sorts = 'created_at desc' if @search.sorts.empty?

    @books = @search.result
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
    @book = Book.find_by(isbn: params[:isbn])
    @bookmark = Bookmark.new
    bookmarks = if (tag_name = params[:tag_name])
      Bookmark.with_tag(tag_name)
    else
      Bookmark.all
    end
    @bookmarks = @book.bookmarks.includes(:user).order(chapter: :asc)
  end

  private

  def move_to_signed_in
    unless user_signed_in?
      redirect_to '/pages/about', info: "ログイン後に使える機能です。"
    end
  end

  def book_params
    params.require(:book).permit(:title, :sales_date, :large_image_url, :item_url, :isbn, :item_price, :item_caption)
  end

  def author_params
    params.require(:book).permit(author: [])
  end

end
