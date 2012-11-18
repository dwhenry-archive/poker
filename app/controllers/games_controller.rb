class GamesController < ApplicationController
  before_filter :require_login
  before_filter :require_owner, :only => [:edit, :update]

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new(params[:game] || {})
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
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(params[:game])
      redirect_to game_path(@game)
    else
      render :edit
    end
  end

  def index
    @games = Game.includes(:location).order('"on" desc, locations.name').all
  end

private

  def require_owner

  end
end
