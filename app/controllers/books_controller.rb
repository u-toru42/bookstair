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
      @books = RakutenWebService::Books::Book.search(title: params[:title_search])
    elsif params[:author_search] && (params[:title_search].nil? || params[:title_search].blank?)
      @books = RakutenWebService::Books::Book.search(author: params[:author_search])
    elsif params[:author_search] && params[:title_search]
      @books = RakutenWebService::Books::Book.search(title: params[:title_search], author: params[:author_search])
    end
  end

  def show
    @book = Book.find_by!(isbn: params[:isbn])
    @comment = Comment.new
    @comments = @book.comments.includes(:user).order(created_at: :desc)
  end

  private  

  def book_params
    params.require(:book).permit(:title, :sales_date, :large_image_url, :item_url, :isbn)
  end

  def author_params
    params.require(:book).permit(author: [])
  end

end