class CreateUserGames < ActiveRecord::Migration
  def change
    create_table :user_games do |t|
      t.integer :user_id
      t.integer :boardgame_id
    end
  end
end
