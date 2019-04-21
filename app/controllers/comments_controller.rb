class CommentsController < ApplicationController

  # ログインしていない限りコメント機能は使えず、該当urlにアクセスしてもトップページにリダイレクト
  before_action :authenticate_user!

  # フォーム内容によりcommentインスタンスを作成し記事詳細ページにリダイレクト
  def create
    Comment.create(comment_params)
    redirect_to post_path(params[:post_id])
  end

  # commentインスタンスのidにより特定したcommentを削除し、記事詳細ページにリダイレクト
  def destroy
    Comment.destroy(params[:id])
    redirect_to post_path(params[:post_id])
  end

  private
  # フォームの入力内容を受け取る
  def comment_params
    params.require(:comment).permit(:text).merge(post_id: params[:post_id], user_id: current_user.id)
  end
end

