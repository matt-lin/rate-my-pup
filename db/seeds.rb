# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


pups = [{:pup_name => 'Chloe', :owner_name => 'Liz Hagearty', :breeder_id => '1', :breed_1 => 'Cocker Spaniel', :breed_2 => 'Poodle', :breeder_responsibility => '5', :overall_health => '5', :trainability => '3', :social_behavior => '4', :energy_level => '4', :simpatico_rating => '5', :comments => 'great dog!'},
  	 	{:pup_name => 'Spot', :owner_name => 'Anna Goodman', :breeder_id => '2', :breed_1 => 'Dalmation', :breed_2 => 'None', :breeder_responsibility => '3', :overall_health => '3', :trainability => '3', :social_behavior => '3', :energy_level => '3', :simpatico_rating => '3', :comments => 'love my dog!'}]
  	 	{:pup_name => 'Gypsy', :owner_name => 'Erik Bartlett', :breeder_id => '1', :breed_1 => 'Akita', :breed_2 => 'None', :breeder_responsibility => '5', :overall_health => '4', :trainability => '3', :social_behavior => '2', :energy_level => '1', :simpatico_rating => '5', :comments => 'not very playful'},
  	 	{:pup_name => 'Jenny', :owner_name => 'Justin MacMillin', :breeder_id => '2', :breed_1 => 'Dalmation', :breed_2 => 'None', :breeder_responsibility => '3', :overall_health => '4', :trainability => '5', :social_behavior => '5', :energy_level => '3', :simpatico_rating => '4', :comments => 'very well behaved!'},
 
breeders = [{:name => 'Justin MacMillin', :location => 'CA', :website => 'www.com', :kennel => 'happy dogs'},
			{:name => 'Alex McGourty', :location => 'CA', :website => 'www.com', :kennel => 'happy dogs 2'}]

breeders.each do |breed|
  Breeder.create!(breed)
end

pups.each do |pup|
  Pup.create!(pup)
end