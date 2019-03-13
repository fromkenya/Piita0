class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit]

   def index
    @posts = Post.order(id: :desc).page(params[:page]).per(15)
  end

  def new
    @post = Post.new
  end

  def create
    Post.create(
      title: post_params[:title],
      body: post_params[:body],
      user_id: current_user.id
      )
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params) if current_user.id == post.user.id
    redirect_to post
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy if current_user.id == post.user.id
    redirect_to post
  end


  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

end

