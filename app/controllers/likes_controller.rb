class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.build(like_params)
    if @like.save
      flash[:success] = "Bookmark created!"
    else
      flash[:error] = "Bookmark creation faild!"
    end
    redirect_to books_path
  end

  def destroy; end

  def bookmark_params
    params.require(:bookmark).permit(:post_id)
  end
end
