class BookmarksController < ApplicationController
  before_action :move_to_signed_in
  require 'faraday'
  require 'oj'
  require 'feedjira'

  def index
    @bookmarks = Bookmark.includes(:book).all.order(updated_at: :desc).page(params[:page]).per(9)
    # ニュースフィード
  end

  def create
    bookmark = current_user.bookmarks.new(bookmark_params)
    if bookmark.save
      redirect_to bookmark_path(bookmark), notice: t('bookmarks.create.success')
    else
      flash[:danger] = if bookmark.errors[:content].include?('contains negative sentiment')
                         # 投稿内容に不備があるか、空白の場合
                         t('bookmarks.create.failure.negative_sentiment')
                       else
                         t('bookmarks.create.failure.else')
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
      flash[:danger] = if bookmark.errors[:content].include?('contains negative sentiment')
                         t('bookmarks.update.failure.else')
                       else
                         t('bookmarks.update.failure.negative_sentiment')
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
    params.require(:bookmark).permit(:headline, :body, :chapter, :link,
                                     :review_star).merge(book_isbn: params[:book_isbn])
  end

  def move_to_signed_in
    return if user_signed_in?

    redirect_to page_path('about'), info: t('bookmarks.move_to_signed_in.failure')
  end
end
