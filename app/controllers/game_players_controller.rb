class GamePlayersController < ApplicationController
  before_filter :require_login
  before_filter :load_game, :except => [:index, :create]
  before_filter :load_game_with_player, :only => [:create]

  def create
    @game.players += [@player]

    redirect_to game_path(@game)
  end

  def destroy
    @game.players -= [@player]

    redirect_to game_path(@game)
  end

  def exit
    @player.exit_game(@game)

    redirect_to game_path(@game)
  end

  def addon
    @player.add_rebuy_chips(@game)

    redirect_to game_path(@game)
  end

  def index
    @game = Game.find(params[:game_id])
    @non_players = Player.where(['id not in (?)', @game.players.map(&:id)])
  end

private

  def load_game
    @game = Game.find(params[:game_id])
    @player = Player.find(player_id)
  end

  def load_game_with_player
    @game = Game.find(params[:game_id])
    if player_id
      @player = Player.find(player_id)
    else
      @player = Player.create(
        name: "#{params[:guest_name]} (Guest)",
        password: 'password',
        password_confirmation: 'password'
      )
    end
  end

  def player_id
    params[:id] || params[:player_id]
  end
end