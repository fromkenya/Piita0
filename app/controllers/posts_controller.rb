class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

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
    @post.update(post_params)
    redirect_to @post
  end

  def destroy
    @post.destroy
    redirect_to @post
  end


  private
  def post_params
    params.require(:post).permit(:title, :body).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def ensure_correct_user
    if @post.user_id != current_user.id
      flash[:alert] = "権限がありません"
      redirect_to posts_path
    end
  end
end

