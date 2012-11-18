class Chip < ActiveRecord::Base
  belongs_to :game_player
  attr_accessible :amount, :chips
end
