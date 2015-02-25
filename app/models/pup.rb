class Pup < ActiveRecord::Base
  attr_accessible :pup_name, :owner_name, :breeder, :breed1, :breed2, :breeder_responsibility, :overall_health, :trainability, :social_behavior, :energy_level, :simpatico_rating, :comments, :breeders, :kennels
end