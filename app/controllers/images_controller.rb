class ImagesController < ApplicationController
  # Finds an image entry in the database and renders the show template
  def show
    @image = Image.find(params[:id])
  end

  # Creates an instance of the image model and passes it to the rendered new view
  def new
    @image = Image.new
  end

  # Accepts a post request and creates a new image entry in the database.
  # Redirects to the show method with the id of the newly created image
  def create
    image = Image.create(image_params)
    redirect_to action: 'show', id: image.id
  end

  private

  # Restrict what parameters will be accepted in posts
  def image_params
    params.require(:image).permit(:url)
  end
end
