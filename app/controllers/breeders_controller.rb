class BreedersController < ApplicationController
  def search_name
    @breeder = Breeder.find_by_name(params[:breeder_name])
    if !@breeder
      redirect_to root_path and return
    end
    @pups = @breeder.pups
  end
end
