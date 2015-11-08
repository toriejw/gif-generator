require 'test_helper'

class GifsHaveCategoriesTest < ActionDispatch::IntegrationTest
  test "gif has a category" do
    login_user
    create_gif

    visit gifs_path

    within(".dog") do
      assert page.has_content?("Dog")
    end

    assert page.has_css?("img")
  end
end
