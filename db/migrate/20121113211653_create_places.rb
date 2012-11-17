class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.references :game
      t.references :player
      t.integer :points

      t.timestamps
    end
    add_index :places, :game_id
    add_index :places, :player_id
  end
end
