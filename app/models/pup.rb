class Pup < ActiveRecord::Base

  belongs_to :breeder
  
	attr_accessible :pup_name, :owner_name, :breeder, :breed_1, :breed_2, :breeder_responsibility, :overall_health,
                  :trainability, :social_behavior, :energy_level, :simpatico_rating, :comments, :kennel

  def Pup.find_by_breeds(breed1, breed2 = nil)
    Rails.logger.info breed1 + breed2 if breed2
    if breed2
      Pup.where(:breed_1 => breed1, :breed_2 => breed2) + Pup.where(:breed_1 => breed2, :breed_2 => breed1)
    else
      Pup.where(:breed_1 => breed1, :breed_2 => nil)
    end
  end

  def Pup.avg_ratings_by_breeds(breed1, breed2 = nil)
    pups_by_breed = Pup.find_by_breeds(breed1, breed2)
    results_hash = {:overall_health => 0, :trainability => 0, :social_behavior => 0,
                    :energy_level => 0, :simpatico_rating => 0}
    pups_by_breed.each do |pup|
      results_hash.each do |rating, value|
        results_hash[rating] += pup.send(rating)
      end
    end
    results_hash.each { |k,v| results_hash[k] = v/pups_by_breed.length.to_f } if pups_by_breed.length > 0
    results_hash
  end


end