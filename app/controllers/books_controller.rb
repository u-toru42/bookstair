class BooksController < ApplicationController
  before_action :move_to_signed_in

  require 'faraday'
  require 'oj'

  def new
    @book = Book.new
  end
  
  def create
    # @book = Book.create(params.permit(:title, :author, :sales_date, :large_image_url, :item_url, :isbn, :item_price, :item_caption))
    @book = Book.create(book_params)
    if @book.valid?
      redirect_to books_path, notice: "「#{@book[:title]}」を保存しました"
    else
      redirect_to books_path, notice: "「#{@book[:title]}」は既に保存されています"
    end
  end

  def destroy
    # button_toのvalueがidになっているがisbnに変換することは可能か
    book = Book.find_by(isbn: params[:isbn])
    book.delete
    redirect_to books_path, danger: "「#{book[:title]}」を削除しました", status: :see_other
  end
  
  def index
    # @books = Book.all.order(created_at: :desc)
    @search = Book.ransack(params[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty?
    @books = @search.result
  end

  def search
    @title_search = params[:title_search].presence
    @author_search = params[:author_search].presence

    if @title_search || @author_search
      # タイトルまたは著者が指定された場合
      query = {
        title: @title_search,
        author: @author_search,
        booksGenreId: Rails.configuration.booksGenreId
      }.compact

      @books = RakutenWebService::Books::Book.search(query)
    else
      # どちらも指定されなかった場合
      @books = []
      flash.now[:notice] = "検索キーワードが入力されていません"
    end
  end

  def autocomplete
    client = Faraday.new(url: 'https://qiita.com') do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
      faraday.headers['Authorization'] = "Bearer #{Rails.application.credentials.qiita[:access_token]}"
      faraday.headers['Content-Type'] = 'application/json'
    end

    res = client.get '/api/v2/tags', { sort: 'count', per_page: 10 }

    tags = Oj.load(res.body, symbol_keys: true).map { |t| t[:name] }

    render json: tags
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
      redirect_to page_path('about'), info: "ログイン後に使える機能です"
    end
  end

  def book_params
    params.require(:book).permit(:title, :author, :sales_date, :large_image_url, :item_url, :isbn, :item_price, :item_caption)
  end

  def author_params
    params.require(:book).permit(author: [])
  end

end
