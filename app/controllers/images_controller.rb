class ImagesController < ApplicationController
  def create
    @image = Image.new(image_params)
    @image.create
  end

  def destroy
  end

  private
  def image_params
    params.permit(:image, :post_id).merge(user_id: current_user.id)
  end
end
