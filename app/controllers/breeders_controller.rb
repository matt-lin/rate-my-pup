class BreedersController < ApplicationController
  def index
    if request.xhr?
      render :json => Breeder.all
    else
      @breeders = Breeder.all
    end
  end
  def search_name
    @breeder = Breeder.find_by_name(params[:breeders][:breeder_name])
    if !@breeder
      flash[:message] = "Sorry there are not reviews for #{params[:breeders][:breeder_name]}"
      redirect_to root_path and return
    end
    @avg_ratings = @breeder.avg_pup_rating
    @pups = @breeder.pups
  end
  def all_breeders

  end
end
