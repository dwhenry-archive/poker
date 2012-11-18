class Game < ActiveRecord::Base
  belongs_to :location
  attr_accessible :on, :location_id

  validates_presence_of :location_id
  validates_presence_of 'on'

  validate :on_is_a_date

  def on_is_a_date
    return if on.blank? or on.is_a?(Date)
    Date.parse(on)
  rescue ArgumentError
    return false
  end
end
