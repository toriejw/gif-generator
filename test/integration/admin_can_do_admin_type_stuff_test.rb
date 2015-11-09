require 'test_helper'

class AdminCanDoAdminTypeStuffTest < ActionDispatch::IntegrationTest
  def create_admin
    User.create(username: "Nala", password: "password", role: 1)
  end

  test "admin can see dashboard" do
    create_admin
    visit login_path

    fill_in "Username", with: "Nala"
    fill_in "Password", with: "password"
    click_button "Login"

    click_link "Dashboard"

    assert_equal admin_categories_path, current_path
    assert page.has_content?("Nala's Dashboard")
  end

  test "User can see dashboard" do
    login_user

    refute page.has_content?("Dashboard")

    visit '/admin/categories'
    assert page.has_content?("404")
  end

end
