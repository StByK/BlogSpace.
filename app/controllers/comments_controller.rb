class CommentsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def destroy
  end

  def update
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :post_id).merge(user_id: current_user.id)
    end
    
end
