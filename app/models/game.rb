class Game < ActiveRecord::Base
  belongs_to :location
  attr_accessible :on

  validates_presence_of :location_id
  validates_presence_of :on

end
