class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.references :location
      t.references :player

      t.timestamps
    end
    add_index :owners, :location_id
    add_index :owners, :player_id
  end
end
