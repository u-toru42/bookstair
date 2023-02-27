class BookmarksController < ApplicationController
  def create
    bookmark = current_user.bookmarks.build(bookmark_params)
    if bookmark.save
      redirect_to book_path(bookmark.book), success: t('defaults.message.created', item: Bookmark.model_name.human)
    else
      redirect_to book_path(bookmark.book), danger: t('defaults.message.created', item: Bookmark.model_name.human)
    end
    # binding.irb
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    Bookmark.delete
    flash[:danger] = "コメントが削除されました"
    redirect_to bookmark.book
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:headline, :body, :page, :chapter, :link, :created_at, tag_ids: []).merge(book_isbn: params[:book_isbn])
  end
end
