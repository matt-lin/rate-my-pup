class Breeder < ActiveRecord::Base
  has_many :pups
  attr_accessible :name, :city, :state, :website, :kennel

  def avg_pup_rating
    results_hash = {:overall_health => 0, :trainability => 0, :social_behavior => 0,
                    :energy_level => 0, :simpatico_rating => 0, :breeder_responsibility => 0}
    Rails.logger.info pups if pups == 10
    pups.each do |pup|
      results_hash.each {|rating,v| results_hash[rating] += pup.send(rating)}
    end
    Hash[results_hash.map { |k,v| [k, v.to_f/pups.length.to_f]}]
  end

  def Breeder.find_by_substring(name, city, state, limit=0)
    # Want to limit the number of AND statements in query so as
    # to limit load on the database
    query_str = Breeder.generate_query_string([["city", city],["state", state]])
    query_values = Breeder.generate_query_values(name, city, state)
    results = Breeder.where(query_str, *query_values)
    # if no limit provided, default to all results
    limit == 0 ? results.all : results.limit(limit)
  end

  private
  def Breeder.generate_query_string(params)
    #only keep non-nil values
    non_nil_params = params.select{ |e| e[1] }
    # create string to take in sanitized values, default include name as query param
    (["name LIKE ?"] + non_nil_params.map { |param| "#{param[0]} LIKE ?"}).join(" AND ")
  end

  private
  def Breeder.generate_query_values(name, city, state)
    ["%#{name}%"] + [city, state].select{ |param| param }.map{ |param| "#{param}%" }
  end

  def Breeder.find_or_create(name, city, state)
    Breeder.where("name = ? AND city = ? AND state = ?", name, city, state).first ||
        Breeder.create!(:name => name, :city => city, :state => state)
  end
end