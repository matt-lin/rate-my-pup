class Breeder < ActiveRecord::Base
  has_many :pups
  attr_accessible :name, :location, :website, :kennel

  def avg_pup_rating
    results_hash = {:overall_health => 0, :trainability => 0, :social_behavior => 0,
                    :energy_level => 0, :simpatico_rating => 0, :breeder_responsibility => 0}
    Rails.logger.info pups if pups == 10
    pups.each do |pup|
      results_hash.each {|rating,v| results_hash[rating] += pup.send(rating)}
    end
    Hash[results_hash.map { |k,v| [k, v.to_f/pups.length.to_f]}]
  end

end