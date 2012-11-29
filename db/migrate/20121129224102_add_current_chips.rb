class AddCurrentChips < ActiveRecord::Migration
  def up
  	add_column :game_players, :current_chips, :integer
  end

  def down
  	remove_column :game_players, :current_chips
  end
end
