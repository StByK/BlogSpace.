class ImagesController < ApplicationController

  def destroy
    image = Image.find(params[:id])
    image.destroy
  end

  private
  def image_params
    params.permit(:image, :post_id).merge(user_id: current_user.id)
  end
end
