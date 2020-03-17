class AddBoardGamesSlug < ActiveRecord::Migration
  def change
    add_column :board_games, :slug, :string
  end
end
