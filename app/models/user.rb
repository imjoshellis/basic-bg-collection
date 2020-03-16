class User < ActiveRecord::Base
  has_secure_password
  has_many :user_games
  has_many :board_games, through: :user_games
end