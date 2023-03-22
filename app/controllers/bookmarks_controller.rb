class BookmarksController < ApplicationController

  def create
    bookmark = current_user.bookmarks.new(bookmark_params)
    if bookmark.save_with_tags(tag_names: params.dig(:bookmark, :tag_names).split(',').uniq)
      redirect_to bookmark_path(bookmark), notice: 'しおりを作成しました。'
    else
      flash.now[:notice] = 'しおりの作成に失敗しました。'
      # @book = Book.find_by!(isbn: params[:isbn])
      return
    end
  end

  def edit
    @bookmark = current_user.bookmarks.find(params[:id])
  end
  
  def update
    if @bookmark.update(bookmark_params)
      @bookmark.save_with_tags(tag_names: params.dig(:bookmark, :tag_names).split(',').uniq)
      redirect_to @bookmark, notice: 'しおりを作成しました。'
    else
      render :edit
    end
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy
    redirect_to bookmark.book, danger: 'しおりが削除されました。'
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:headline, :body, :chapter, :link, :review_star, :created_at).merge(book_isbn: params[:book_isbn])
  end

end
