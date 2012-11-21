class GamePlayer < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  attr_accessible :game_id, :player_id, :position
  has_many :chips

  after_create :add_buyin_chips

  def add_buyin_chips
    if game.buyin_chips
      chips.create(chips: game.buyin_chips, amount: game.buyin_amount)
    end
  end

  def add_rebuy_chips
    if game.rebuy_chips
      chips.create(chips: game.rebuy_chips, amount: game.rebuy_amount)
    end
  end

  def exit_game
    update_attributes(:position => game.game_players.reject(&:position).count)
  end
end
