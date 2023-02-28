class BookmarksController < ApplicationController
  def create
    bookmark = current_user.bookmarks.new(bookmark_params)
    if bookmark.save_with_tags(tag_names: params.dig(:bookmark, :tag_names).split(',').uniq)
      redirect_to bookmark_path(bookmark), success: 'しおりを作成しました'
    else
      flash.now[:danger] = 'しおりを作成できませんでした'
      render :new
    end
    # if bookmark.save
    #   redirect_to book_path(bookmark.book), success: t('defaults.message.created', item: Bookmark.model_name.human)
    # else
    #   redirect_to book_path(bookmark.book), danger: t('defaults.message.created', item: Bookmark.model_name.human)
    # end
  end
  
  def update
    bookmark.assign_attributes(bookmark_params)
    if bookmark.save_wit_tags(tag_names: params.dig(:bookmark, :tag_names).split(',').uniq)
      redirect_to bookmark_path(bookmark), success: 'しおりを更新しました'
    else
      flash.now[:danger] = 'しおりを更新できませんでした'
      render :edit
    end
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    Bookmark.delete!
    redirect_to bookmark.book, success: 'しおりが削除されました'
  end


  private

  def bookmark_params
    params.require(:bookmark).permit(:headline, :body, :page, :chapter, :link, :created_at).merge(book_isbn: params[:book_isbn])
  end
end
