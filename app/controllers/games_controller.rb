class GamesController < ApplicationController
  before_filter :require_login

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(params[:game])
    if @game.save_with_player(current_user)
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def index
    @games = Game.includes(:location).order('"on" desc, locations.name').all
  end
end
