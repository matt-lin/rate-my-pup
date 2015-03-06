class PupsController < ApplicationController

  def index
    @pups = Pup.all
  end

  def new

  end

  def create
    @pup = Pup.create!(params[:pup])
    flash[:notice] = "#{@pup.pup_name} was successfully added"
    redirect_to pups_path
  end

end
