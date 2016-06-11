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
    name, limit= params[:name], params[:limit].to_i
    render :json => Breeder.find_by_substring(name, limit)
  end

  def search_name
    search_str = params[:breeder][:name]
    @breeder = Breeder.find_by_formatted_string(search_str)
    if !@breeder
      flash[:notice] = "Sorry, we do not yet have any ratings for #{search_str}"
      redirect_to root_path and return
    end
    @avg_ratings = @breeder.avg_pup_rating
    @pups = @breeder.pups
  end

  def create
    name, city, state = params[:name], params[:city], params[:state]
    breeder, message = Breeder.create!(:name => name, :city => city, :state => state)
    if breeder
      redirect_to new_pup_path(:button_clicked => "Create", :breeder_id => breeder.id)
    else
      flash[:message] = message
      redirect_to root_path
    end
  end

end