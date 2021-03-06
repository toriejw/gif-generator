require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest

  def create_user
    User.create(username: "Leon", password: "password")
  end

  test "registered user can login with correct username and password" do
    create_user
    visit '/'

    click_link "Login"
    assert_equal login_path, current_path

    fill_in "Username", with: "Leon"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal user_path(User.find_by(username: "Leon")), current_path
    assert page.has_content?("Leon's Favourites")
  end

  test "registered user can't login with wrong password" do
    create_user
    visit login_path

    fill_in "Username", with: "Leon"
    fill_in "Password", with: "wrongpassword"
    click_button "Login"

    assert_equal login_path, current_path
    assert page.has_content?("Invalid login")
  end

  test "unregistered user can't login" do
    create_user
    visit login_path

    fill_in "Username", with: "Samantha"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal login_path, current_path
    assert page.has_content?("Invalid login")
  end

end
