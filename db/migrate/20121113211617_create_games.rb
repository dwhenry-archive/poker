class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :location
      t.date :on

      t.timestamps
    end
    add_index :games, :location_id
  end
end
