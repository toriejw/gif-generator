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

  def create_dog_gif(num)
    num.times do
      visit new_admin_category_path

      fill_in "Name", with: "dog"
      click_button "Create Gif"
    end
  end

  test "admin can see dashboard" do
    login_admin
    click_link "Dashboard"

    assert_equal admin_categories_path, current_path
    assert page.has_content?("Nala's Dashboard")
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

    refute page.has_css?("img")
  end

  test "admin can delete a caterory" do
    login_admin
    create_dog_gif(2)
    first(".delete_dog").click_link("Delete")

    refute page.has_css?("img")
    refute page.has_content?("Dog")
  end

  test "User can't see dashboard" do
    login_user

    refute page.has_content?("Dashboard")

    visit '/admin/categories'
    assert page.has_content?("404")
  end

  test "user can't delete category or gif" do
    login_user
    visit gifs_path

    refute page.has_link?("Delete")
  end

  test "user can't add gif" do
    login_user
    visit '/admin/categories/new'

    assert page.has_content?("404")
  end
end
