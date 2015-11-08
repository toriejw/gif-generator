require 'test_helper'

class UserCanSeeGifsTests < ActionDispatch::IntegrationTest
  test "user can see gif index" do
    create_gif
    login_user
    click_link "All Gifs"

    assert_equal gifs_path, current_path
    assert page.has_content?('All Gifs')
    assert page.has_css?("img")
  end
end
