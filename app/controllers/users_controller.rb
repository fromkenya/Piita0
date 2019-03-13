class UsersController < ApplicationController
  def index
  end



  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(15)
  end


end
