class LikesController < ApplicationController

  # ログインしていない限りいいね機能は使えず、当該urlにアクセスしてもトップページにリダイレクト
  before_action :authenticate_user!

  # ユーザ詳細ページにおいて、そのユーザに紐ついたlikeインスタンス(1頁15個)をid降順で取得し、@likesに代入
  def index
    @user = User.find(params[:user_id])
    @likes = @user.likes.order(id: :desc).page(params[:page]).per(15)
  end

  # ログイン中ユーザからuser_idを、urlからpost_idを取得しlikeインスタンスを作成、そして記事詳細ページへリダイレクト
  def create
    Like.create(post_id: params[:post_id], user_id: current_user.id)
    redirect_to post_path(params[:post_id])
  end

  # ログイン中ユーザからuser_idと、urlからpost_idを取得し特定したいいねを削除、そして記事詳細ページへリダイレクト
  def destroy
    like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    like.destroy
    redirect_to post_path(params[:post_id])
  end
end
