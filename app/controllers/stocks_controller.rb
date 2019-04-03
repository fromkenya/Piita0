class StocksController < ApplicationController

  def index
    @stocks = current_user.stocks.order(id: :desc).page(params[:page]).per(15)
  end

  def create
    Stock.create(post_id: params[:post_id], user_id: current_user.id)
    redirect_to post_path(params[:post_id])
  end

  def destroy
    stock = Stock.find_by(post_id: params[:post_id], user_id: current_user.id)
    stock.destroy
    redirect_to post_path(params[:post_id])
  end
end

