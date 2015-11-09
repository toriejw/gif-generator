class GifsController < ApplicationController
  def index
    @categories = Category.all
  end

  def destroy
    Gif.destroy(params[:id])
    redirect_to gifs_path
  end
end
