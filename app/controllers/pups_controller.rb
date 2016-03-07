class PupsController < ApplicationController

  before_filter :breeder_exists, :only => :create

  # Devise. Methods not in the list below will require a user to be logged in.
  before_filter :authenticate_user!, except: [:index, :new, :main, :show, :breed]

  def add_breeder_first
    print params
  end

  def breeder_exists
    if params[:pup][:breeder_id].to_i == -1
      breeder = Breeder.find_or_create(params[:breeder][:name], params[:breeder][:city], params[:breeder][:state])
      params[:pup][:breeder_id] = breeder.id
    end
  end

  def index
    @pups = Pup.all
  end

  def new
    if not user_signed_in?
      redirect_to '/users/sign_in'
    end
    @all_breeds = Pup.all_breeds
    @all_breeds_none = Pup.all_breeds_none
  end

  def main
    @all_breeds = Pup.all_breeds
    @all_breeds_none = Pup.all_breeds_none
    @all_breeders = Breeder.all.map {|breeder| breeder.name}
    @mission_statement_sections = Text.mission_statement_sections
  end

  def show
    @pup = Pup.find params[:id]
  end

  def create
    @pup = Pup.new(params[:pup])
    if @pup.save
      flash[:notice] = "#{@pup.pup_name} was successfully added"
      redirect_to breed_path(:pup => {:breed_1 => @pup.breed_1, :breed_2 => @pup.breed_2})
    else 
      flash.keep[:notice] = "Please make sure all fields are complete!"
      redirect_to new_pup_path
    end
  end

  def breed
    breed_1, breed_2 = params[:pup][:breed_1], params[:pup][:breed_2]
    @pups = Pup.find_by_breeds(breed_1, breed_2)
    if @pups.length == 0
      flash[:message] = "Sorry, there are no dogs of the breed #{breed_1}"
      flash[:message] += " and #{breed_2}" if breed_2 != 'None'
      redirect_to root_path and return
    end
    @avg_ratings = Pup.avg_ratings_by_breeds(breed_1, breed_2)
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

  def dog_name

  end

  def dog_how_long

  end

  def dog_breed
    @all_breeds = Pup.all_breeds
    @all_breeds_none = Pup.all_breeds_none
  end

  def dog_breeder

  end
end
