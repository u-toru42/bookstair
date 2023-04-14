class BookmarksController < ApplicationController

  before_action :set_rss
  require 'faraday'
  require 'oj'
  require 'feedjira'
  require 'rss' 

  def index
    @bookmarks = Bookmark.includes(:book).all.order(updated_at: :desc)
    # ニュースフィード
    @feeds = Feed.all.order(updated_at: :asc)
    @show_feeds = true
  end

  def create
    bookmark = current_user.bookmarks.new(bookmark_params)
    if bookmark.save
      redirect_to bookmark_path(bookmark), notice: 'しおりを作成しました'
    else
      flash[:danger] = 'しおりの作成に失敗しました'
      # flash.keep(:danger)
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
      # redirect_to bookmark_path(@bookmark), notice: 'しおりを更新しました'
      redirect_to @bookmark.book, notice: 'しおりを更新しました'
    else
      flash[:danger] = 'しおりの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy
    redirect_to bookmark.book, danger: 'しおりが削除されました'
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:headline, :body, :chapter, :link, :review_star).merge(book_isbn: params[:book_isbn])
  end

  def set_rss
    @feeds = Feed.all
  end

end
