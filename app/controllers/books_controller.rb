class BooksController < ApplicationController
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.create(params.permit(:title, :author, :sales_date, :large_image_url, :item_url, :isbn))
    if @book.valid?
      redirect_to books_path, notice: "「#{@book[:title]}」を保存しました。"
    else
      redirect_to books_path, notice: "「#{@book[:title]}」は既に保存されています。"
    end
  end

  def destroy
    # button_toのvalueがidになっているがisbnに変換することは可能か
    book = Book.find_by(isbn: params[:isbn])
    book.destroy
    redirect_to books_path, danger: "「#{book[:title]}」を削除しました。", status: :see_other
  end
  
  def index
    @books = Book.all
  end

  def search
    if params[:title_search].nil? && params[:author_search].nil?
      return
    elsif params[:title_search].blank? && params[:author_search].blank?
      flash.now[:notice] = '検索キーワードが入力されていません'
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

end