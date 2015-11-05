require 'test_helper'

class UserRegistrationTest < ActionDispatch::IntegrationTest
  test "guest can register with valid credentials" do
    visit new_user_path

    fill_in "Username", with: "Torie"
    fill_in "Password", with: "password"
    click_button "Create Account"

    assert_equal user_path(User.find_by_username("Torie")), current_path
    assert page.has_content?("Torie's Favourites")
  end
end
