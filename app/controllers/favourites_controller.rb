class FavouritesController < ApplicationController
  def create
    gif = Gif.find(params[:gif])
    current_user.favourite_gif(gif)
    redirect_to gifs_path
  end
end
