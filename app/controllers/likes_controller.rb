class LikesController < ApplicationController

  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @likes = @user.likes.order(id: :desc).page(params[:page]).per(15)
  end

  def create
    Like.create(post_id: params[:post_id], user_id: current_user.id)
    redirect_to post_path(params[:post_id])
  end

  def destroy
    like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    like.destroy
    redirect_to post_path(params[:post_id])
  end
end
