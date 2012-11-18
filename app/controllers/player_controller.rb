class PlayerController < ApplicationController
  before_filter :require_login, :except => [:new, :create]

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(params[:player])
    if @player.save
      redirect_to player_path(@player)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end
end
