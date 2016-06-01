#encoding: utf-8

pups = [{:pup_name => 'Chloe', :breeder_id => '1', :breed_1 => 'Cocker Spaniel', :breed_2 => 'Poodle', :breeder_responsibility => '5', :overall_health => '5', :trainability => '3', :social_behavior => '4', :energy_level => '4', :simpatico_rating => '5', :comments => 'great dog!'},
  	 	{:pup_name => 'Spot', :breeder_id => '2', :breed_1 => 'Dalmatian', :breed_2 => 'None', :breeder_responsibility => '3', :overall_health => '3', :trainability => '3', :social_behavior => '3', :energy_level => '3', :simpatico_rating => '3', :comments => 'love my dog!'},
  	 	{:pup_name => 'Gypsy', :breeder_id => '1', :breed_1 => 'Akita', :breed_2 => 'None', :breeder_responsibility => '5', :overall_health => '4', :trainability => '3', :social_behavior => '2', :energy_level => '1', :simpatico_rating => '5', :comments => 'not very playful'},
  	 	{:pup_name => 'Jenny', :breeder_id => '2', :breed_1 => 'Dalmatian', :breed_2 => 'None', :breeder_responsibility => '3', :overall_health => '4', :trainability => '5', :social_behavior => '5', :energy_level => '3', :simpatico_rating => '4', :comments => 'very well behaved!'}]
 
breeders = [{:name => 'Justin MacMillin', :city => "Porterville", :state => 'CA', :website => 'www.com', :kennel => 'happy dogs'},
			{:name => 'Alex McGourty', :city => "San Francisco", :state => 'CA', :website => 'www.com', :kennel => 'happy dogs 2'}]

text = [
    {:section_title => "Mission Statement", :section_order => 1, :title => "Our Mission", :text => 'Our Mission is to create a database of user-generated content about companion dogs and dog breeders, designed to help dog lovers find simpatico puppies with whom to share their homes and lives.'},
    {:section_title => "Mission Statement", :section_order => 2, :title => "Background", :text => 'Background'},
    {:section_title => "Mission Statement", :section_order => 3, :title => "Goals", :text => 'Goals'},
    {:section_title => "Mission Statement", :section_order => 4, :title => "How You Can Help", :text => 'How You Can Help'}
]

breeders.each do |breed|
  Breeder.create!(breed)
end

pups.each do |pup|
  Pup.create!(pup)
end

text.each do |text|
  Text.create!(text)
end