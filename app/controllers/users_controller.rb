class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render :new
    end
  end

<<<<<<< HEAD
  def me; end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :user_name)
=======
  private

  def user_params
<<<<<<< HEAD
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
>>>>>>> 200e31c (ログイン機能実装(ログアウト機能が未完成))
=======
    params.require(:user).permit(:email, :password, :password_confirmation, :user_name)
>>>>>>> 06b00fa (i18n、decorator、ユーザー名絡む名をname->user_nameに変更)
  end
end
