class PupsController < ApplicationController

  before_filter :breeder_exists, :only => :create
  before_filter :check_sign_in, :only => [:new, :dog_name, :dog_how_long, :dog_breed, :dog_breeder]

  # Devise. Methods not in the list below will require a user to be logged in.
  before_filter :authenticate_user!, except: [:index, :new, :main, :show, :breed, :search_breed]


  def breeder_exists
    if params[:pup][:breeder_id].to_i == -1
      breeder = Breeder.find_or_create(params[:breeder][:name], params[:breeder][:city], params[:breeder][:state])
      params[:pup][:breeder_id] = breeder.id
    end
  end



  # The Root Path
  def main
    start_over
    @texts = Text.all
  end



  # The true rating page
  def new
    if !session[:step1] || !session[:step2] || !session[:step3]
      redirect_to root_path and return
    end
    if params[:breeder] && params[:breeder][:new] == "new"
      redirect_to create_breeder_path(:name => params[:new_breeder][:name], :city => params[:new_breeder][:city], :state => params[:new_breeder][:state]) and return
    end
    button_clicked = params[:button_clicked]
    if button_clicked == "Create" && params[:breeder_id]
      session[:breeder_id] = params[:breeder_id]
      return
    end
    if button_clicked == "Next"
      breeder_str = params[:breeder][:name]
      breeder = Breeder.find_by_formatted_string(breeder_str)
      if breeder
        session[:breeder_id] = breeder.id
        return
      end
    end
    flash[:notice] = "Invalid breeder/kennel name. If you don't want to provide breeder/kennel name, please leave it blank."
    redirect_to dog_breeder_path(:button_clicked => "Next", :breed => {:name => session[:breed]}) and return
  end



  # Rails default methods
  def index
    @pups = Pup.all
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



  #################### Start Questionnaire ####################

  # step 0
  def dog_name
  end

  # step 1
  def dog_how_long
    pup_name = params[:pup][:name]
    if pup_name.nil? || pup_name.empty?
      flash[:notice] = "Please input a name"
      session[:step1] = false
      redirect_to dog_name_path and return
    else
      session[:pup_name] = pup_name
      session[:step1] = true
    end
  end

  #step2
  def dog_breed
    years = params[:pup][:years]
    months = params[:pup][:months]
    tmp_session = {:name => session[:pup_name]}
    if !session[:step1]
      redirect_to root_path and return
    end
    if years.nil? || months.nil? || (years.empty? && months.empty?)
      flash[:notice] = "Please enter how long you have owned your dog."
    elsif (!years.empty? && !is_num?(years)) || (!months.empty? && !is_num?(months))
      flash[:notice] = "Please enter a valid integer number for year/month."
    elsif is_valid_year_month?(years, months)
      session[:years] = years
      session[:months] = months
      session[:step2] = true
      return
    else
      flash[:modal] = "modal"
    end
    session[:step2] = false
    redirect_to dog_how_long_path(:pup => tmp_session) and return
  end

  #step3
  def dog_breeder
    breed = params[:breed][:name]
    if !session[:step1] || !session[:step2]
      redirect_to root_path and return
    end
    if Pup.is_valid_breed breed
      session[:breed] = breed
      session[:step3] = true
      @states = ['AL - Alabama', 'AK - Alaska', 'AZ - Arizona', 'AR - Arkansas',
                 'CA - California', 'CO - Colorado', 'CT - Connecticut', 'DE - Delaware',
                 'FL - Florida', 'GA - Georgia', 'HI -  Hawaii', 'ID -  Idaho',
                 'IL - Illinois', 'IN - Indiana', 'IA - Iowa', 'KS - Kansas',
                 'KY - Kentucky', 'LA - Louisiana', 'ME - Maine', 'MD - Maryland',
                 'MA - Massachusetts', 'MI - Michigan', 'MN - Minnesota', 'MS - Mississippi',
                 'MO - Missouri', 'MT - Montana', 'NE - Nebraska', 'NV - Nevada',
                 'NH - New Hampshire', 'NJ - New Jersey', 'NM - New Mexico', 'NY - New York',
                 'NC - North Carolina', 'ND - North Dakota', 'OH - Ohio', 'OK - Oklahoma',
                 'OR - Oregon', 'PA - Pennsylvania', 'RI - Rhode Island', 'SC -South Carolina',
                 'SD - South Dakota', 'TN - Tennessee', 'TX - Texas', 'UT - Utah',
                 'VT - Vermont', 'VA - Virginia', 'WA - Washington', 'WV - West Virginia',
                 'WI - Wisconsin', 'WY -  Wyoming']
    else
      session[:step3] = false
      flash[:modal] = "modal"
    end
  end

  #################### End Questionnaire ####################



  # search for breeds when doing auto-fill
  def search_breed
    name = params[:name]
    render :json => Breed.find_breed_by_substr(name)
  end

  # search pups by breed name
  def breed
    name = params[:breed][:name]
    if !Breed.is_valid_breed(name)
      flash[:notice] = "Please enter a vild breed name."
      redirect_to root_path
    end
    @pups = Pup.find_by_breed(name)
    @avg_ratings = Pup.avg_ratings_by_breed(name)
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

  def is_num?(str)
    Integer(str)
    return true
  rescue ArgumentError, TypeError
    return false
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
end
  
