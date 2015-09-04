class CreateBoardGames < ActiveRecord::Migration
  def change
    create_table :board_games do |t|

      t.timestamps null: false
    end
  end
end
