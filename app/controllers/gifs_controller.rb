class GifsController < ApplicationController
  api_key = "dc6zaTOxFJmzC"
  search_terms = "dog"

  connection = Hurley::Client.new "http://api.giphy.com"
  request = "/v1/gifs/search?q=#{search_terms}&api_key=#{api_key}"
  response = connection.get(request)

  def index
    @gifs = Gif.all
  end
end
