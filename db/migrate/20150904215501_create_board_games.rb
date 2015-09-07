class CreateBoardGames < ActiveRecord::Migration
  def change
    create_table :board_games do |t|

      t.timestamps null: false
      t.string :title
      t.string :creator
      t.text :description
      t.integer :min_players
      t.integer :max_players
      t.integer :bgg_score
      t.integer :min_time
      t.integer :max_time
    end
  end
end
