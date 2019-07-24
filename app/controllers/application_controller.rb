class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def home
    @images = Image.order(created_at: :desc)
    @images = @images.tagged_with(params[:tag]) if params[:tag]
  end
end
