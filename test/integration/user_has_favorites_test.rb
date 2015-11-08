require 'test_helper'

class UserHasFavoritesTest < ActionDispatch::IntegrationTest
  test "user can mark gif as favorite" do
    user = login_user
    create_gif

    visit user_path(user)
    refute page.has_css?("img")

    visit gifs_path
    first(".gif").click_link("Favourite")

    visit user_path(user)
    assert page.has_css?("img")
  end

  test "user can unfavorite gifs" do
    user = login_user
    gif = create_gif
    favorite_gif(user, gif)
    visit gifs_path

    refute page.has_content?("Favourite")

    first(".gif").click_link("Unfavourite")

    visit user_path(user)
    refute page.has_css?("img")

    visit gifs_path
    assert page.has_content?("Favourite")
  end
end
