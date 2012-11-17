class LoginController < ApplicationController
  def new
    @player = Player.new
  end

  def create
    if @player = Player.create(name: params[:name], passowrd: params[:password])
      session[:user_id] = @player.id
      redirect_last_or_root
    else
      render :new
    end
  end
end
