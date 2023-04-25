class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorite_books = current_user.favorites.map(&:book)
    @bookmark_counts = {}
    @favorite_books.each do |book|
      @bookmark_counts[book.id] = book.bookmarks.count
    end
    @bookmarks = Bookmark.all
  end

  def create
    @book = Book.find_by(isbn: params[:book_isbn])
    favorite = @book.favorites.new(user_id: current_user.id)
    if favorite.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    @book = Book.find_by(isbn: params[:book_isbn])
    favorite = @book.favorites.find_by(user_id: current_user.id)
    if favorite.present?
        favorite.destroy
        redirect_to request.referer
    else
        redirect_to request.referer
    end
  end
end
