class PupsController < ApplicationController

  before_filter :breeder_exists, :only => :create
  before_filter :check_sign_in, :only => [:new, :dog_name, :dog_how_long, :dog_breed, :dog_breeder]

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
    breeder_name = params[:potato][:poops]
    if !session[:step1] || !session[:step2] || !session[:step3]
      redirect_to root_path and return
    end
    if breeder_name.nil? || breeder_name.empty?
      flash[:notice] = "Enter your breeder's name"
      session[:step4] = false
      redirect_to dog_breeder_path(:pup => {:breed_1 => session[:breed1], :breed2 => session[:breed2]}) and return
    else
      session[:breeder_name] = breeder_name
      session[:step4] = true
    end
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
    byebug
    param = params[:pup]
    
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
    pup_name = params[:pup][:pup_name]
    if pup_name.nil? || pup_name.empty?
      flash[:notice] = "Please enter a name for your dog"
      session[:step1] = false
      redirect_to dog_name_path and return
    else
      session[:pup_name] = pup_name
      session[:step1] = true
    end
  end

  def dog_breed
    @all_breeds = Pup.all_breeds
    @all_breeds_none = Pup.all_breeds_none
    years = params[:pup][:years]
    months = params[:pup][:months]
    if !session[:step1]
      redirect_to root_path and return
    end
    if years.nil? || months.nil? || (years.empty? && months.empty?)
      flash[:notice] = "Please enter how long you have owned your dog."
      session[:step2] = false
      redirect_to dog_how_long_path(:pup => {:pup_name => session[:pup_name]}) and return
    elsif is_valid_year_month?(years, months)
      session[:years] = years 
      session[:months] = months
      session[:step2] = true
    else
      session[:step2] = false
      flash[:notice] = "Sorry, to keep the information in our database as accurate as possible, we are collecting data only for dogs that have been in the current home for at least six months. Please come back and evaluate your dog later."
      redirect_to root_path and return
    end
  end

  def dog_breeder
    multiple_breeds = params[:multiple_breeds]
    breed1 = params[:pup][:breed1]
    breed2 = params[:pup][:breed2]
    if !session[:step1] || !session[:step2]
      redirect_to root_path and return
    end
    if multiple_breeds == "Purebred"
      session[:breed1] = breed1
      session[:breed2] = breed2
      session[:multiple_breeds] = multiple_breeds
      session[:step3] = true
    else
      session[:step3] = false
      flash[:notice] = "Sorry, to keep the information in our database as accurate as possible, we are only collecting data for dogs that are members of a recognized AKC breed."
      redirect_to root_path and return
    end
  end

  def is_valid_breed?(breed1, breed2)
    # code here
    # if breed1.nil?
    #   return Pup.all_breeds.include?(breed2)
    # elsif breed2.nil?
    #   return Pup.all_breeds.include?(breed1)
    # else
    #   return (Pup.all_breeds.include?(breed1) and Pup.all_breeds.include?(breed2))
    # end
  end

  private
  def check_sign_in
    unless user_signed_in?
      redirect_to '/users/sign_in'
    end
  end
  
  def is_valid_year_month?(years, months)
    return years.to_i * 12 + months.to_i >= 6
  end
end
