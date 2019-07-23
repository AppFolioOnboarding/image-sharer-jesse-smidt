class SharesController < ApplicationController
  before_action :set_image
  def new
    @share_form = ShareForm.new
  end

  def create
    @share_form = ShareForm.new(share_params)
    if @share_form.valid?
      ImageShareMailer.share_email(
        share_form: @share_form, image: @image, linkback_url: request.base_url
      ).deliver!
      redirect_to root_path, notice: "You have sent an image to #{@share_form.email}"
    else
      render :new
    end
  end

  private

  def share_params
    params.require(:share_form).permit(:email, :message)
  end

  def set_image
    @image = Image.find(params[:image_id])
  end
end
