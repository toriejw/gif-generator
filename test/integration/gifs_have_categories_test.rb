require 'test_helper'

class GifsHaveCategoriesTest < ActionDispatch::IntegrationTest
  test "gif has a category on index page" do
    login_user
    create_gif

    visit gifs_path

    within(".dog") do
      assert page.has_content?("Dog")
    end

    assert page.has_css?("img")
  end

  test "gif has a category on user page" do
    user = login_user
    gif = create_gif
    favorite_gif(user, gif)
    visit user_path(user)

    within(".dog") do
      assert page.has_content?("Dog")
    end

    assert page.has_css?("img")
  end
end
