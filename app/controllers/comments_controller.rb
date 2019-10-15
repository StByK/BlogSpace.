class CommentsController < ApplicationController
  def index
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to "/posts/#{@comment.post_id}", notice: "コメントを投稿しました"
    else
      redirect_to root_path, alert: "コメントの投稿に失敗しました"
    end
  end

  def edit
  end

  def destroy
  end

  def update
  end

  private
    def comment_params
      params.permit(:content, :post_id).merge(user_id: current_user.id)
    end

end
