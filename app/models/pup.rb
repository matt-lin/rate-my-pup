class Pup < ActiveRecord::Base

  belongs_to :breeder

  attr_accessible :pup_name, :owner_name, :breeder, :breed_1, :breed_2, :breeder_responsibility, :overall_health, :trainability, :social_behavior, :energy_level, :simpatico_rating, :comments, :kennel
end