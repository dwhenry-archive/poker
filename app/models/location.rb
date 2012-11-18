class Location < ActiveRecord::Base
  attr_accessible :name, :owning_players

  validates_uniqueness_of :name
  has_many :owners
  has_many :games
  has_many :owning_players, :through => :owners, :source => :player

  scope :owner_by, lambda{ |player|
    includes(:owners).where(['owners.player_id = ?', player.id])
  }

  def save_with_owner(player)
    ActiveRecord::Base.transaction do
      save!
      self.owning_players << player
      self
    end
  end
end
