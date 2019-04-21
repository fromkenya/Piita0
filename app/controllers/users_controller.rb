class UsersController < ApplicationController

  # ユーザ詳細ページでそのユーザに結びついたpostインスタンス(1頁15個)をid降順で取得し、@postsに代入
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page]).per(15)
  end
end
