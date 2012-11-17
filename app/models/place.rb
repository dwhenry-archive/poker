class Place < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  attr_accessible :points
end
