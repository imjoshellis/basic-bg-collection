class User < ActiveRecord::Base
  validates :username, :password, :slug, presence: true, format: {with: /[a-zA-Z0-9\-\_]/}, length: {in: 3..12}
  validates :slug, uniqueness: true

  has_secure_password

  has_many :user_games
  has_many :board_games, through: :user_games
end
