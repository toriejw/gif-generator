require 'test_helper'

class UserCanSeeGifsTests < ActionDispatch::IntegrationTest
  def login_user
    User.create(username: "Aria", password: "starwars")
    visit login_path
    fill_in "Username", with: "Aria"
    fill_in "Password", with: "starwars"
    click_button "Login"
  end

  def create_gif
    Gif.create(url: "http://media3.giphy.com/media/WTl5quTRtvj32/giphy.gif")
  end

  test "user can see gif index" do
    create_gif
    login_user
    click_link "All Gifs"

    assert_equal gifs_path, current_path
    assert page.has_content?('All Gifs')
    assert page.has_css?("img")
  end
end
