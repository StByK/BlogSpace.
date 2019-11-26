class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :deny_unknown_user, only: [:new]
  before_action :deny_wrong_user, except: [:new, :create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    post = params[:post_id] 
    if @comment.save
      redirect_to post_path(post), notice: "コメントを投稿しました"
    else
      redirect_to root_path, alert: "コメントの投稿に失敗しました"
    end
  end

  def edit
  end

  def update
    @comment.update(comment_params) if @comment.user_id == current_user.id
    if @comment.update(comment_params)
      redirect_to "/posts/#{params[:post_id]}"
    else
      redirect_to "/posts/#{params[:post_id]}", alert: "エラー：編集できませんでした"
    end
  end

  def destroy
    @comment.destroy if @comment.user_id == current_user.id
    if @comment.destroy
      redirect_to "/posts/#{params[:post_id]}", notice: "コメントを削除しました"
    end
  end

  private
    def comment_params
      params.permit(:content, :post_id).merge(user_id: current_user.id)
    end

    def deny_unknown_user
      redirect_to root_path unless user_signed_in?
    end

    def deny_wrong_user
      redirect_to root_path unless user_signed_in? && @comment.user_id == current_user.id
    end
  
    def set_comment
      @comment = Comment.find(params[:id])
    end

end
