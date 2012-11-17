class Game < ActiveRecord::Base
  belongs_to :location
  attr_accessible :on
end
