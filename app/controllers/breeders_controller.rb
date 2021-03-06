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
    @pups = @breeder.all_pups
  end

  def new

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
  end

  def create
    name, city, state = params[:breeder][:name], params[:breeder][:city], params[:breeder][:state]
    breeder, message = Breeder.create!(:name => name, :city => city, :state => state)
    if !breeder
      flash[:message] = message
    end
    redirect_to dog_breeder_path
  end

end