class SharesController < ApplicationController
  before_action :set_image
  def new
    @share = Share.new

    puts params[:image_id]
  end

  def create
    @share = Share.new(email: share_params[:email], message: share_params[:message])
    if @share.valid?
      ImageShareMailer.share_email(share: @share, image: @image, linkback_url: request.base_url).deliver!
      redirect_to root_path, success: "You have sent an image to #{@share.email}"
    else
      render :new
    end
  end

  private

  def share_params
    params.require(:share).permit(:email, :message)
  end

  def set_image
    @image = Image.find(params[:image_id])
  end
end
