class PostsController < ApplicationController

before_action :intercept_unknown_user, except: [:index, :show]
before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 9).order("id DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path, notice: "投稿が完了しました"
    else
      redirect_to root_path, alert: "エラー：投稿できませんでした"
    end
  end

  def show
    @author = User.find(@post.user_id)
    @comments = Comment.where(post_id: params[:id]).order("id DESC")
  end

  def edit
  end

  def filter
    @posts = Post.where(user_id: current_user.id).paginate(page: params[:page], per_page: 9).order("id DESC")
  end

  def update
    post.update(post_params) if post.user_id == current_user.id
    if post.update(post_params)
      redirect_to "/posts/#{params[:id]}"
    else
      redirect_to "/posts/#{params[:id]}", alert: "エラー：編集できませんでした"
    end
  end

  def destroy
    post.destroy if post.user_id == current_user.id
    if post.destroy
      redirect_to root_path, notice: "投稿を削除しました"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content).merge(user_id: current_user.id)
  end

  def intercept_unknown_user
    redirect_to root_path unless user_signed_in?
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
