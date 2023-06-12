class BookmarksController < ApplicationController
  before_action :move_to_signed_in
  before_action :set_rss
  require 'faraday'
  require 'oj'
  require 'feedjira'
  require 'rss' 

  def index
    @bookmarks = Bookmark.includes(:book).all.order(updated_at: :desc).page(params[:page]).per(9)
    # ニュースフィード
    @feeds = Feed.all.order(updated_at: :asc)
    @show_feeds = true
  end

  def create
    bookmark = current_user.bookmarks.new(bookmark_params)
    if bookmark.save
      redirect_to bookmark_path(bookmark), notice: t('bookmarks.create.success')
    else
      if bookmark.errors[:content].include?("contains negative sentiment")
        flash[:danger] = t('bookmarks.create.failure.negative_sentiment')
      else
        flash[:danger] = t('bookmarks.create.failure.else')
      end
      @book = Book.find_by(isbn: params[:isbn])
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @bookmark = current_user.bookmarks.find(params[:id])
  end

  def update
    @bookmark = current_user.bookmarks.find(params[:id])
    if @bookmark.update!(bookmark_params.merge(book: @bookmark.book))
      redirect_to @bookmark.book, notice: t('bookmarks.update.success')
    else
      if bookmark.errors[:content].include?("contains negative sentiment")
        flash[:danger] = t('bookmarks.update.failure.negative_sentiment')
      else
        flash[:danger] = t('bookmarks.update.failure.else')
      end
      render :edit
    end
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy
    redirect_to bookmark.book, danger: t('bookmarks.destroy.success')
  end

  def my_bookmarks
    @bookmarks = Bookmark.where(user_id: current_user.id).order(updated_at: :desc).page(params[:page]).per(9)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:headline, :body, :chapter, :link, :review_star).merge(book_isbn: params[:book_isbn])
  end

  def set_rss
    @feeds = Feed.all
  end

  def move_to_signed_in
    unless user_signed_in?
      redirect_to page_path('about'), info: t('bookmarks.move_to_signed_in.failure')
    end
  end

end
