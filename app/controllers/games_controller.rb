class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def index
    @games = Game.includes(:location).order('"on" desc, locations.name').all
  end
end
