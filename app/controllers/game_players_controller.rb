class GamePlayersController < ApplicationController
  before_filter :require_login
  before_filter :load_game

  def create
    @game.players += [@player]

    redirect_to game_path(@game)
  end

  def destroy
    @game.players -= [@player]

    redirect_to game_path(@game)
  end

  def exit
    game_player = @game.game_players.detect{|gp| gp.player == @player}
    game_player.update_attributes(:position => @game.game_players.reject(&:position).count)

    redirect_to game_path(@game)
  end

  def addon
    game_player = @game.game_players.detect{|gp| gp.player == @player}
    game_player.chips.create(:chips => @game.rebuy_chips, :amount => @game.rebuy_amount)

    redirect_to game_path(@game)
  end

private

  def load_game
    @game = Game.find(params[:game_id])
    @player = Player.find(params[:id] || params[:player_id])
  end
end