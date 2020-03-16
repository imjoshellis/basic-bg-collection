class UserGames < ActiveRecord::Base
  belongs_to :board_games
  belongs_to :users
end
