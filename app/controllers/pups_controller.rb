class PupsController < ApplicationController

  def index
    @pups = Pup.all
  end

  def new

  end

  def show
    @pup = Pup.find params[:id]
  end

  def create
    @pup = Pup.create!(params[:pup])
    flash[:notice] = "#{@pup.pup_name} was successfully added"
    redirect_to pups_path
  end
  def breed
    @pups = Pup.find_by_breeds(params[:breed1], params[:breed2])
    @avg_ratings = Pup.avg_ratings_by_breeds(params[:breed1], params[:breed2])
  end

  def update
    @pup = Pup.find params[:id]
    @pup.update_attributes(params[:pup])
    redirect_to pups_path
  end
  def destroy
    @pup = Pup.find params[:id]
    @pup.destroy
    redirect_to pups_path
  end

end
