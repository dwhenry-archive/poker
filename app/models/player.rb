class Player < ActiveRecord::Base
  attr_accessible :name, :nickname, :password, :password_confirmation
  attr_accessor :password_confirmation

  validates_presence_of :name
  validates_presence_of :password
  validate :matching_password
  has_many :player_games, :class_name => 'GamePlayer'

  def self.login(name, password)
    user = find_by_name(name)
    if user && user.password == password
      user
    end
  end

  def chips_for(game)
    chips = player_games.detect{|pg| pg.game == game}.chips
    stats = {chips: 0, amount: 0}
    chips.each_with_object(stats) do |chip, stats|
      stats[:chips] += chip.chips
      stats[:amount] += chip.amount
    end
  end

  def details(game)
    game_player = player_games.detect{ |pg| pg.game == game }
    chips = game_player.chips

    str = []
    str << name
    if game_player.position
      if chips.empty?
        str << "(#{placed(game, game_player)})"
      else
        str << "(#{chip_count(chips, false)}, #{placed(game, game_player)})"
      end
    else
      str << "(#{chip_count(chips)})" unless chips.empty?
    end
    str
  end

private

  def placed(game, game_player)
    "placed #{game_player.position}/#{game.players.count}"
  end

  def chip_count(chips, still_playing=true)
    if still_playing
      "#{chips.last.chips}/#{chips.sum(&:chips)} chips"
    else
      "0/#{chips.sum(&:chips)}"
    end
  end

  def matching_password
    return true unless password.blank? || changed.include?(:password) || password_confirmation
    if password != password_confirmation
      errors.add(:password_confirmation, 'should match password')
    end
  end
end
