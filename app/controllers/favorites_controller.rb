class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorite_books = current_user.favorites.map(&:book).sort_by { |book| book.bookmarks.count }.reverse
    @bookmark_counts = {}
    @favorite_books.each do |book|
      @bookmark_counts[book.id] = book.bookmarks.count
    end
    @bookmarks = Bookmark.all
  end

  def create
    @book = Book.find_by(isbn: params[:book_isbn])
    current_user.favorite(@book)

    render turbo_stream: turbo_stream.replace("favorite-button-#{@book.isbn}", partial: 'books/unfavorite', locals: { book: @book })
  end

  def destroy
    @book = Book.find_by(isbn: params[:isbn])
    current_user.unfavorite(@book)

    render turbo_stream: turbo_stream.replace("favorite-button-#{@book.isbn}", 
                                              partial: 'books/favorite', 
                                              locals: { book: @book })
  end
end
