class BreedersController < ApplicationController
  skip_before_filter :delete_pup_from_session, :except => [:index, :substring_match, :search_name]

  def index
    if request.xhr?
      render :json => Breeder.all
    else
      @breeders = Breeder.all
    end
  end

  def search_breeder
    name, city, state, limit= params[:name], params[:city], params[:state], params[:limit].to_i
    render :json => Breeder.find_by_substring(name, city, state, limit)
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

  def search_spot
    city, state = params[:city], params[:state]
    closest = Breeder.near(city + ", " + state)
    render :json => closest.limit(10)
  end

  def create
    name, city, state = params[:breeder][:name], params[:breeder][:city], params[:breeder][:state]
    breeder, message = Breeder.find_or_create(name, city, state)
    if session[:pup]
      session[:pup][:breeder_id] = breeder.id
      redirect_to create_pup_path(:pup => session[:pup])
    else
      flash[:message] = message
      redirect_to root_path
    end
  end

end
