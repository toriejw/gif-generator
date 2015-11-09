require 'test_helper'

class AdminCanDoAdminTypeStuffTest < ActionDispatch::IntegrationTest
  def create_admin
    User.create(username: "Nala", password: "password", role: 1)
  end

  def login_admin
    create_admin
    visit login_path

    fill_in "Username", with: "Nala"
    fill_in "Password", with: "password"
    click_button "Login"
  end

  test "admin can see dashboard" do
    login_admin
    click_link "Dashboard"

    assert_equal admin_categories_path, current_path
    assert page.has_content?("Nala's Dashboard")
  end

  test "User can't see dashboard" do
    login_user

    refute page.has_content?("Dashboard")

    visit '/admin/categories'
    assert page.has_content?("404")
  end

  test "Admin can create gif" do
    login_admin

    click_link "Dashboard"

    click_link "Create Gif"

    fill_in "Name", with: "dog"
    click_button "Create Gif"

    visit gifs_path
    assert page.has_css?("img")
    assert page.has_content?("Dog")
  end

  test "admin can delete a gif" do
    create_gif
    login_admin

    click_link "All Gifs"
    first(".gif").click_link("Delete")    
  end

end
