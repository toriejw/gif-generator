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

  test "guess can't register with taken username" do
    User.create(username: "Ryan", password: "Bieber")

    visit new_user_path

    fill_in "Username", with: "Ryan"
    fill_in "Password", with: "password"
    click_button "Create Account"

    assert_equal new_user_path, current_path
    assert page.has_content?("Username has already been taken")
  end

  test "guest can't register without username" do
    visit new_user_path

    fill_in "Password", with: "chocolate"
    click_button "Create Account"

    assert_equal new_user_path, current_path
    assert page.has_content?("Username can't be blank")
  end

  test "guest can't register without password" do
    skip
    visit new_user_path

    fill_in "Username", with: "chocolate"
    click_button "Create Account"

    assert_equal new_user_path, current_path
    assert page.has_content?("Password can't be blank")
  end
end
