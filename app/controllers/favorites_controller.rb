class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all
    @favorite_books = current_user.favorites.map(&:book).sort_by { |book| book.bookmarks.count }.reverse
    @bookmark_counts = {}
    @favorite_books.each do |book|
      @bookmark_counts[book.id] = book.bookmarks.count
    end
    @bookmarks = Bookmark.all
    @favorites = Favorite.where(book_isbn: @books.pluck(:isbn), user_id: current_user.id)
  end

  def create
    @book = Book.find_by(isbn: params[:book_isbn])
    favorite_action(@book)
  end

  def destroy
    @book = Book.find_by(isbn: params[:book_isbn])
    favorite_action(@book)
  end

  private

  def favorite_action(book)
    favorite = current_user.favorites.find_or_initialize_by(book_isbn: book.isbn)
    if favorite.new_record?
      favorite.save!
    else
      current_user.unfavorite(book)
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("favorite-button-#{book.isbn}", partial: 'books/favorite_button', locals: { book: book, favorite: favorite })
      end
    end
  end
end