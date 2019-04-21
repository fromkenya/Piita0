class PostsController < ApplicationController

  #トップページか記事詳細ページにアクセスする場合を除き、ログインしていない限りトップページにリダイレクト
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  #postインスタンス(1頁15個)をid降順で@postsに代入
  def index
    @posts = Post.order(id: :desc).page(params[:page]).per(15)
  end

  #postモデルに関連付いたフォームを生成するためにpostインスタンスを作成
  def new
    @post = Post.new
  end

  #フォーム内容によりpostインスタンスを作成し、保存に成功すればトップページにリダイレクト、失敗すれば新規投稿画面を再描画
  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = '投稿を作成しました'
      redirect_to posts_path
    else
      render new_post_path(@post)
    end
  end

  #commentモデルに関連付いたフォームを生成するためにcommentインスタンスを生成(postインスタンスはset_postメソッドにより特定)
  def show
    @comment = Comment.new
  end

  #フォーム内容によりpostインスタンスを編集し、保存に成功すればトップページにリダイレクト、失敗すれば投稿編集画面を再描画
  def update
    if @post.update(post_params)
      flash[:notice] = '投稿を編集しました'
      redirect_to @post
    else
      render 'posts/edit'
    end
  end

  #set_postメソッドにより特定されたpostインスタンスを削除
  def destroy
    @post.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_to @post
  end


  private
  #フォームの入力内容を受け取る
  def post_params
    params.require(:post).permit(:title, :body).merge(user_id: current_user.id)
  end

  #urlから取得したidによりpostインスタンスを特定
  def set_post
    @post = Post.find(params[:id])
  end

  #記事投稿者とログイン中のユーザが一致しない限り記事の編集削除を不可能にする
  def ensure_correct_user
    if @post.user_id != current_user.id
      flash[:alert] = "権限がありません"
      redirect_to posts_path
    end
  end
end

