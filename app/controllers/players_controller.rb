class PlayersController < ApplicationController
  before_filter :require_login, :except => [:new, :create]

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(params[:player])
    if @player.save
      session[:user_id] = @player.id
      redirect_last_or_root
    else
      render :new
    end
  end

  def show
    @player = Player.find(params[:id])
  end

  def edit
  end

  def update
  end
end
