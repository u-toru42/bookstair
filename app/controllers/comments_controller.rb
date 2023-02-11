class CommentsController < ApplicationController
  def create
    @book = Book.find_by!(isbn: params[:isbn])
    comment = current_user.comments.build(comment_params)
    comment.isbn = @book.isbn
    if comment.save
      redirect_to book_path(comment.book), success: t('defaults.message.created', item: Comment.model_name.human)
    else
      redirect_to book_path(comment.book), danger: t('defaults.message.created', item: Comment.model_name.human)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    flash[:danger] = "コメントが削除されました"
    redirect_to comment.book
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(isbn: params[:isbn])
  end
end
