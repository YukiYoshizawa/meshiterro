class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  #ログインしているユーザーと現在のユーザーが一致しているか判定

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end
  #ログインしているユーザーと現在のユーザーが一致しているか判定の処理を使い回すのでまとめた。
end
