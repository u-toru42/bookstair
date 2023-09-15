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
    favorite = current_user.favorites.find_or_initialize_by(book_isbn: @book.isbn)
    favorite.save!

    render turbo_stream: turbo_stream.replace("favorite-button-#{@book.isbn}",
                                              partial: 'books/unfavorite',
                                              locals: { book: @book, favorite: favorite })
  end

  def destroy
    @book = Book.find_by(isbn: params[:book_isbn])
    current_user.unfavorite(@book)
    render turbo_stream: turbo_stream.replace("favorite-button-#{@book.isbn}", partial: 'books/favorite', locals: { book: @book })
  end
end
