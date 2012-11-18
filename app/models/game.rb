class Game < ActiveRecord::Base
  belongs_to :location
  has_many :game_players
  has_many :players, :through => :game_players
  attr_accessible :on, :location_id, :buyin_chips, :buyin_amount, :rebuy_chips, :rebuy_amount

  validates_presence_of :location_id
  validates_presence_of 'on'

  validate :on_is_a_date


  def non_players
    (Player.all - players)
  end

  def save_with_player(player)
    ActiveRecord::Base.transaction do
      begin
        save!
        self.players << player
        return self
      rescue ActiveRecord::RecordInvalid
        raise ActiveRecord::Rollback
      end
    end
    false
  end

  def on_is_a_date
    return if on.blank? or on.is_a?(Date)
    Date.parse(on)
  rescue ArgumentError
    return false
  end
end
