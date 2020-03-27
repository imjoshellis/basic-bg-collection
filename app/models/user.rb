class User < ActiveRecord::Base
  validates :username, :password, presence: true
  validates :slug, uniqueness: true
  validates :username, :password, length: {in: 3..12}
  has_secure_password
  has_many :user_games
  has_many :board_games, through: :user_games
end
