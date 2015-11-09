class User < ActiveRecord::Base
  has_secure_password
  validates :username, uniqueness: true, presence: true

  has_many :favourites
  has_many :gifs, through: :favourites

  enum role: %w(default admin)

  def favourite_gif(gif)
    self.gifs << gif
  end
end
