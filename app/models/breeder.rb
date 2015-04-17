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
    results = Breeder.where(
        "name LIKE ? AND state LIKE ? AND city LIKE ?",
        "#{name}%",
        "#{state}%",
        "#{city}%"
    )
    limit == 0 ? results.all : results.limit(limit)
  end

  def Breeder.find_or_create(name, city, state, website="")
    Breeder.where("name = ? AND city = ? and state = ?", name, city, state).first ||
        Breeder.create!(:name => name, :website => website)
  end
end