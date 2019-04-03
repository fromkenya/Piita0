class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

   def index
    @posts = Post.order(id: :desc).page(params[:page]).per(15)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render new_post_path(@post)
    end
  end

  def show
    @comment = Comment.new
  end

  def update
    post.update(post_params) if current_user.id == post.user.id
    redirect_to post
  end

  def destroy
    post.destroy if current_user.id == post.user.id
    redirect_to post
  end


  private
  def post_params
    params.require(:post).permit(:title, :body).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end

