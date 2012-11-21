class LoginController < ApplicationController
  def new
    @player = Player.new
  end

  def create
    if @player = Player.login(params[:name], params[:password])
      session[:user_id] = @player.id
      redirect_last_or_root
    else
      @player ||= Player.new(params.slice(:name))
      render :new, :status => 404
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def now
    raise 'for test and dev only' if Rails.env.production?
    session[:user_id] = params[:id]
    redirect_last_or_root
  end
end
