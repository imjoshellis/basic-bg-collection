class CreateBoardgames < ActiveRecord::Migration
  def change
    create_table :boardgames do |t|
      t.string :name
      t.string :bgg_url
    end
  end
end
