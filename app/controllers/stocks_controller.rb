class StocksController < ApplicationController

  # ログインしていない限りストック機能は使えず、当該urlにアクセスしてもトップページにリダイレクト
  before_action :authenticate_user!

  # ログイン中のユーザがストックしたstockインスタンス(1頁15個)をid降順で@stocksに代入
  def index
    @stocks = current_user.stocks.order(id: :desc).page(params[:page]).per(15)
  end

  # ログイン中ユーザからuser_idを、urlからpost_idを取得しstockインスタンスを作成、そして記事詳細ページへリダイレクト
  def create
    Stock.create(post_id: params[:post_id], user_id: current_user.id)
    redirect_to post_path(params[:post_id])
  end

  # ログイン中ユーザからuser_idと、urlからpost_idを取得し特定したstockインスタンスを削除、そして記事詳細ページへリダイレクト
  def destroy
    stock = Stock.find_by(post_id: params[:post_id], user_id: current_user.id)
    stock.destroy
    redirect_to post_path(params[:post_id])
  end
end

