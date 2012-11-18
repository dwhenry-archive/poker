class AddPositionToGamePlayer < ActiveRecord::Migration
  def change
    add_column :game_players, :position, :integer
  end
end
