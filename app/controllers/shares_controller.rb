class SharesController < ApplicationController
  def new
    @share = Share.new
    @image = Image.find(params[:image_id])
    puts params[:image_id]
  end

  def create
    @share = Share.new(email: share_params[:email], message: share_params[:message])
    @image = Image.find(params[:image_id])
    if @share.valid?
      ImageShareMailer.share_email(share: @share, image: @image, linkback_url: request.base_url).deliver
      flash[:success] = "You have sent an image to #{@share.email}"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def share_params
    params.require(:share).permit(:email, :message)
  end
end
