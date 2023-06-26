class UsersController < ApplicationController
  before_action :move_to_signed_in
  before_action :set_user, only: [:show, :edit, :update]
  
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

  def me; end

  def show; end

  def edit
    if current_user.name == "ゲストユーザー"
      flash[:info] = t('devise.failure.guest_account')
      redirect_to user_path(current_user)
    elsif @user != current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  def set_user
    @user = User.find(current_user.id)
  end

  def move_to_signed_in
    unless user_signed_in?
      redirect_to page_path('about'), info: t('devise.failure.unauthenticated')
    end
  end
end
