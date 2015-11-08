ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'mocha/mini_test'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def login_user
    user = User.create(username: "Aria", password: "starwars")
    visit login_path
    fill_in "Username", with: "Aria"
    fill_in "Password", with: "starwars"
    click_button "Login"
    user
  end

  def create_gif
    Gif.create(url: gif_source)
  end

  def gif_source
    "http://media3.giphy.com/media/WTl5quTRtvj32/giphy.gif"
  end

  def teardown
    reset_session!
  end
end
