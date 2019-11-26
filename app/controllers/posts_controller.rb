class PostsController < ApplicationController

before_action :intercept_unknown_user, except: [:index, :show]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 9).order("id DESC")
  end

  def new
    @post = Post.new
    @image = @post.images.build
    @tag = @post.tags.build
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      if params[:images].present?
        params[:images]['image'].each do |i|
          @image = @post.images.create!(image: i)
        end
      end
      tag_list = params[:tag_name].split(",")
      @post.save_tags(tag_list)
      redirect_to root_path, notice: "投稿が完了しました"
    else
      redirect_to root_path, alert: "エラー：投稿できませんでした"
    end
  end

  def show
    @post = Post.find(params[:id])
    @author = User.find(@post.user_id)
    @comments = Comment.where(post_id: params[:id]).order("id DESC")
    @images = @post.images.all
    @like = Like.new
  end

  def edit
    @images = @post.images.all
  end

  def filter
    @posts = Post.where(user_id: current_user.id).paginate(page: params[:page], per_page: 9).order("id DESC")
  end

  def update
    @post.update(post_params) if @post.user_id == current_user.id
    if @post.update(post_params)
      # params[:images]['image'].each do |i|
      #   @image = @post.images.update(image: i)
      # end
      redirect_to "/posts/#{params[:id]}"
    else
      redirect_to "/posts/#{params[:id]}", alert: "エラー：編集できませんでした"
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy if post.user_id == current_user.id
    if post.destroy
      redirect_to root_path, notice: "投稿を削除しました"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, images_attributes: [:image], tags_attributes: :name).merge(user_id: current_user.id)
  end

  def update_post_params
    params.require(:post).permit(:title, :content, images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def intercept_unknown_user
    redirect_to root_path unless user_signed_in?
  end

end
