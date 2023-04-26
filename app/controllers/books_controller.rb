class BooksController < ApplicationController
  before_action :move_to_signed_in
  before_action :set_rss

  require 'faraday'
  require 'oj'
  require 'feedjira'
  require 'rss'

  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: '書籍を登録しました。' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # button_toのvalueがidになっているがisbnに変換することは可能か
    book = Book.find_by(isbn: params[:isbn])
    book.delete
    redirect_to books_path, danger: "「#{book[:title]}」を削除しました", status: :see_other
  end
  
  def index
    # 従来の検索
    @search = Book.ransack(params[:q])

    @search.sorts = 'created_at desc' if @search.sorts.empty?

    @books = @search.result.page(params[:page])

    # ニュースフィード
    @feeds = Feed.all.order(updated_at: :asc)
    @show_feeds = true

    @bookmark_counts = {}
    @books.each do |book|
      @bookmark_counts[book.id] = book.bookmarks.count
    end
    @bookmarks = Bookmark.all
    # @word_count = Feed.word_count
  end
  
  def bookmark_index
    @bookmarks = Bookmark.all
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
    # ニュースフィード
    @feeds = Feed.all
    @show_feeds = true
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
    update_click_count(@book.isbn)
    @bookmark = Bookmark.new
    bookmarks = if (tag_name = params[:tag_name])
      Bookmark.with_tag(tag_name)
    else
      Bookmark.all
    end
    @bookmarks = @book.bookmarks.includes(:user).order(chapter: :asc)
    @bookmark_counts = @book.bookmarks.count
    # ニュースフィード
    @feeds = Feed.all
    @show_feeds = true
    # screenshot = ScreenshotCapture::Screenshot.new(url: book_url(@book))
    # @screenshot_url = screenshot.url

  end

  def update_click_count(book_isbn)
    click = Click.find_or_initialize_by(book_isbn: book_isbn)
    click.update(clicks: click.clicks + 1)
  end

  private

  def set_rss
    @feeds = Feed.all
  end

  def move_to_signed_in
    unless user_signed_in?
      redirect_to page_path('about'), info: "ログイン後に使える機能です"
    end
  end

  def book_params
    params.permit(:title, :author, :sales_date, :large_image_url, :item_url, :isbn, :item_price, :item_caption)
  end

end
