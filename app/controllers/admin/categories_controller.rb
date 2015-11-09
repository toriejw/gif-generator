class Admin::CategoriesController < Admin::BaseController
  def index
  end

  def new

  end

  def create
    search_terms = params[:category][:name]
    gif_url = get_gif(search_terms)

    gif = Gif.create(url: gif_url)
    category = Category.find_or_create_by(name: search_terms)
    category.gifs << gif

    redirect_to gifs_path
  end

  def get_gif(search_terms)
    api_key = "dc6zaTOxFJmzC"
    search_terms = search_terms.split(" ").join("+")

    connection = Hurley::Client.new "http://api.giphy.com"
    request = "/v1/gifs/search?q=#{search_terms}&api_key=#{api_key}"
    response = connection.get(request)
    body = parse_response(response.body)
    body["data"][0]["images"]["original"]["url"]
  end

  def parse_response(response)
    JSON.parse(response)
  end
end
