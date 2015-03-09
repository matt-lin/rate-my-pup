class PupsController < ApplicationController
  
  def index
    @pups = Pup.all
  end

  def new
    @all_breeds = Pup.all_breeds
    @all_breeds_none = Pup.all_breeds_none
  end

  def main
    @all_breeds = Pup.all_breeds
    @all_breeds_none = Pup.all_breeds_none
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
    pup_breeds = params[:pup]
    @pups = Pup.find_by_breeds(pup_breeds[:breed_1], pup_breeds[:breed_2])
    @avg_ratings = Pup.avg_ratings_by_breeds(pup_breeds[:breed_1], pup_breeds[:breed_2])
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
