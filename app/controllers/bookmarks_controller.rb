class BookmarksController < ApplicationController
  def index
  end

  # def create
  #   @book = Book.find(params[:book_id])
  #   bookmark = @book.bookmarks.new(user_id: current_user.id)
  #   if bookmark.save
  #     redirect_to request.referer
  #   else
  #     redirect_to request.referer
  #   end
  # end

  def destroy
    @book = Book.find(params[:book_id])
    bookmark = @book.bookmarks.find_by(user_id: current_user.id)
    if bookmark.present?
      bookmark.destroy
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end
end
