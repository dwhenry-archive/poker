class Player < ActiveRecord::Base
  attr_accessible :name, :nickname, :password, :password_confirmation
  attr_accessor :password_confirmation

  validates_presence_of :name
  validates_presence_of :password
  validate :matching_password
  has_many :player_games, :class_name => 'GamePlayer'

  def self.login(name, password)
    user = where(["name like ? or nickname like ?", name, name]).first
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
    game_player = player_game(game)
    chips = game_player.chips

    str = []
    str << identity
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

  def add_buyin_chips(game)
    player_game(game).add_buyin_chips
  end

  def add_rebuy_chips(game)
    player_game(game).add_rebuy_chips
  end

  def exit_game(game)
    player_game(game).exit_game
  end

  def identity
    nickname || name
  end

  def full_identity
    str = ''
    str << name
    str << " (#{nickname})" if nickname
    str
  end

  def player_game(game)
    player_games.detect{ |pg| pg.game == game }
  end

private


  def placed(game, game_player)
    "placed #{game_player.position}/#{game.players.count}"
  end

  def chip_count(chips, still_playing=true)
    total_chips = chips.sum(&:chips)
    if still_playing
      "#{format(chips.last.chips)}/#{format(total_chips)} chips"
    else
      "0/#{format(total_chips)}"
    end
  end

  def format(num)
    num.to_s.
        reverse.
        split('').
        in_groups_of(3, false).
        map{|n| n.join }.
        join(',').
        reverse
  end

  def matching_password
    return true unless password.blank? || changed.include?(:password) || password_confirmation
    if password != password_confirmation
      errors.add(:password_confirmation, 'should match password')
    end
  end
end
