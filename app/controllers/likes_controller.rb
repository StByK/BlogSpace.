class LikesController < ApplicationController
  def create
    @like = current_user.likes.create!(post_id: params[:post_id]) if user_signed_in?
    redirect_to "/posts/#{params[:post_id]}"
  end

  def destroy
    like = current_user.likes.find_by(post_id: params[:post_id])
    like.destroy if user_signed_in?
    redirect_to "/posts/#{params[:post_id]}"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

end
