class AddDefaultChipsAndBuyinToGame < ActiveRecord::Migration
  def change
    add_column :games, :buyin_chips, :integer
    add_column :games, :buyin_amount, :integer

    add_column :games, :rebuy_chips, :integer
    add_column :games, :rebuy_amount, :integer
  end
end
