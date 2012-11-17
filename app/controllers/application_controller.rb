class ApplicationController < ActionController::Base
  protect_from_forgery
  attr_accessor :current_user

  def require_login
    unless session[:user_id] && @current_user = PLayer.find_by_id(session[:user_id])
      session[:last] = request.referer
      redirect_to login_path
    end
  end

  def redirect_last_or_root
    if last = session[:last]
      session[:last] = nil
      redirect_to session[:last]
    else
      redirect_to root_path
    end
  end

end
