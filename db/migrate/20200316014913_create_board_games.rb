class CreateBoardGames < ActiveRecord::Migration
  def change
    create_table :board_games do |t|
      t.string :name
      t.string :bgg_url
    end
  end
end
