class ImagesController < ApplicationController
  def index
    @images = Image.order(created_at: :desc)
    @images = @images.tagged_with(params[:tag]) if params[:tag]
  end

  def show
    @image = Image.find(params[:id])
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)

    if @image.valid?
      @image.save
      redirect_to image_path(@image)
    else
      render :new
    end
  end

  def destroy
    Image.delete(params[:id])

    redirect_to root_path
  end

  private

  def image_params
    params.require(:image).permit(:url, :tag_list)
  end
end
