class Breeder < ActiveRecord::Base
  has_many :pups
  attr_accessible :name, :city, :state, :website, :kennel, :removed_reviews

  geocoded_by :address
  after_validation :geocode

  def address
    if self.city and self.state
      self.city + ', ' + self.state
    else
      ""
    end
  end

  def avg_pup_rating
    results_hash = {:overall_health => 0, :trainability => 0, :social_behavior => 0,
                    :energy_level => 0, :simpatico_rating => 0, :breeder_responsibility => 0}
    pups.each do |pup|
      results_hash.each {|rating,v| results_hash[rating] += pup.send(rating)}
    end
    Hash[results_hash.map { |k,v| [k, v.to_f/pups.length.to_f]}]
  end

  def increment_deleted_reviews
    update_attributes(:removed_reviews => removed_reviews + 1)
    save!
  end

  def Breeder.find_by_substring(name, city, state, limit = 0, breeders = nil)
    # Want to limit the number of AND statements in query so as
    # to limit load on the database
    # #breeders input allows for chaining of where clauses
    breeders = breeders || Breeder
    query_str = Breeder.generate_query_string([["city", city], ["state", state]])
    query_values = Breeder.generate_query_values(name, city, state)
    limit == 0 ? breeders.where(query_str, *query_values) : breeders.where(query_str, *query_values).limit(limit)
  end
  
  def Breeder.is_valid_breeder(name)
    breeder = Breeder.where("name = ?", name)
    return breeder.any?
  end

  def Breeder.intersect_by_substring_and_breed(query_values, limit=0)
    breeders_by_breed = Breeder.find_breeders_by_breed(query_values[:breed_1], query_values[:breed_2])
    results = Breeder.find_by_substring(
        query_values[:name],
        query_values[:city],
        query_values[:state],
        breeders_by_breed
    )
    # if no limit provided, default to all results
    limit == 0 ? results.all : results.limit(limit)
  end

  def Breeder.find_breeders_by_breed(breed_1, breed_2, breeders = nil)
    #breeders input allows for chaining of where clauses
    breeders = breeders || Breeder
    by_breed = Pup.find_by_breeds(breed_1, breed_2).select(:breeder_id)
    breeders.where(id: by_breed)
  end

  def Breeder.find_or_create(name, city, state)
    Breeder.where("name = ? AND city = ? AND state = ?", name, city, state).first ||
        Breeder.create!(:name => name, :city => city, :state => state)
  end

  private
  def Breeder.generate_query_string(params)
    #only keep non-nil values
    non_nil_params = params.select{ |e| e[1] }
    # create string to take in sanitized values, default include name as query param
    (["name LIKE ? OR name LIKE ?"] + non_nil_params.map { |param| "#{param[0]} LIKE ?"}).join(" AND ")
  end

  private
  def Breeder.generate_query_values(name, city, state)
    ["#{name}%"] + ["% #{name}%"] + [city, state].select{ |param| param }.map{ |param| "#{param}%" }
  end
end