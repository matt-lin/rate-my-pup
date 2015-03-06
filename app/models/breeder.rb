class Breeder < ActiveRecord::Base
  has_many :pups
  attr_accessible :name, :location, :website, :kennel
end