class CreateChips < ActiveRecord::Migration
  def change
    create_table :chips do |t|
      t.references :game_player
      t.integer :chips
      t.integer :amount

      t.timestamps
    end
    add_index :chips, :game_player_id
  end
end
