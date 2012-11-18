class LocationsController < ApplicationController
  before_filter :require_login

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params[:location])
    if @location.save_with_owner(current_user)

      redirect_to new_game_path(:game => {:location_id => @location.id})
    else
      render :new
    end
  end

  def edit
  end

  def update
  end
end
