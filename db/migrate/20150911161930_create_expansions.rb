class CreateExpansions < ActiveRecord::Migration
  def change
    create_table :expansions do |t|

      t.timestamps null: false
      t.string :title
      t.string :creator
      t.string :image
      t.text :description
      t.integer :min_players
      t.integer :max_players
      t.integer :min_time
      t.integer :max_time
      t.integer :bgg_score
    end
  end
end
