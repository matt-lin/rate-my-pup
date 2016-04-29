class PupsController < ApplicationController

  before_filter :breeder_exists, :only => :create
  before_filter :check_sign_in, :only => [:new, :dog_name, :dog_how_long, :dog_breed, :dog_breeder]

  # Devise. Methods not in the list below will require a user to be logged in.
  before_filter :authenticate_user!, except: [:index, :new, :main, :show, :breed]

  def add_breeder_first
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
    breeder_name = params[:breeder][:name]
    button_clicked = params[:button_clicked]
    # button_clicked = params[:button_clicked]
    if !session[:step1] || !session[:step2] || !session[:step3]
      redirect_to root_path and return
    end
    if button_clicked != "Next"
      session[:breeder_name] = "unknown"
      session[:breeder_id] = 0
    elsif !breeder_name.empty? && !Breeder.is_valid_breeder(breeder_name)
      flash[:notice] = "Invalid breeder name"
      redirect_to dog_breeder_path(:button_clicked => "Next", :breed => {:name => session[:breed]}) and return
    else
      session[:breeder_name] = breeder_name
      session[:breeder_id] = params[:breeder_id]
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
    param = params[:pup]
    param[:pup_name] = session[:pup_name]
    param[:breed_1] = session[:breed]
    param[:breed_2] = 'None'
    param[:breeder_id] = session[:breeder_id]
    @pup = Pup.new(param)
    if @pup.save
      flash[:notice] = "Thank You! #{@pup.pup_name} was successfully added to our database."
      redirect_to root_path
    else 
      flash[:notice] = "Please make sure all fields are complete!"
      redirect_to new_pup_path
    end
  end

  def breed
    breed_1, breed_2 = params[:breed][:name], 'None'
    @pups = Pup.find_by_breeds(breed_1, breed_2)
    # if not Pup.legal_dog(breed_1)
    if @pups.length == 0
      flash[:notice] = "Sorry, there are no dogs of the breed #{breed_1}"
      flash[:notice] += " and #{breed_2}" if breed_2 != 'None'
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
      flash[:notice] = "Please input a name"
      session[:step1] = false
      redirect_to dog_name_path and return
    else
      session[:pup_name] = pup_name
      session[:step1] = true
    end
  end

  def dog_breed
    years = params[:pup][:years]
    months = params[:pup][:months]
    if !session[:step1]
      redirect_to root_path and return
    end
    if years.nil? || months.nil? || (years.empty? && months.empty?)
      flash[:notice] = "Please enter how long you have owned your dog."
      session[:step2] = false
      redirect_to dog_how_long_path(:pup => {:pup_name => session[:pup_name]}) and return
    elsif (!years.empty? && !is_num?(years)) || (!months.empty? && !is_num?(months))
      flash[:notice] = "Please enter a valid integer number for year/month."
      session[:step2] = false
      redirect_to dog_how_long_path(:pup => {:pup_name => session[:pup_name]}) and return
    elsif is_valid_year_month?(years, months)
      session[:years] = years
      session[:months] = months
      session[:step2] = true
    else
      tmp_session = {:pup_name => session[:pup_name]}
      start_over
      flash[:modal] = "To keep our database as accurate as possible,
we are collecting information only for dogs that have been residing 
in their current home for six months or more. Please come back to our 
site and rate your dog (or insert the dog's name) after s/he has lived 
with you for a minimum of six months. Thank you."
      redirect_to dog_how_long_path(:pup => tmp_session) and return
    end
  end

  def dog_breeder
    breed = params[:breed][:name]
    button_clicked = params[:button_clicked]
    if !session[:step1] || !session[:step2]
      redirect_to root_path and return
    end
    if button_clicked == "Next"
      if !Pup.is_valid_breed(breed)
        flash[:notice] = "Please select a breed in the list."
        redirect_to dog_breed_path(:pup => {:years => session[:years], :months => session[:months]}) and return
      end
      session[:breed] = breed
      session[:step3] = true
    else
      start_over
      redirect_to root_path and return
    end
  end

  def search_breed
    name = params[:name]
    render :json => Pup.find_breed_by_name(name)
  end

  private
  def check_sign_in
    unless user_signed_in?
      redirect_to welcome_path
    end
  end
  
  def is_valid_year_month?(years, months)
    return years.to_i * 12 + months.to_i >= 6
  end
  
  def start_over
    session[:step1] = false
    session[:step2] = false
    session[:step3] = false
    session[:pup_name] = nil
    session[:breed] = nil
    session[:years] = nil
    session[:months] = nil
  end

  def is_num?(str)
    Integer(str)
    return true
  rescue ArgumentError, TypeError
    return false
  end
end
  
