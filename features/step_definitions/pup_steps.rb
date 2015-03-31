require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

Given /the following ratings exist/ do |pups_table|
  breeder = FactoryGirl.create(:breeder, :name => "George W. Bush")
  pups_table.hashes.each do |rating|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Pup.create!(
      pup_name: 'Thor',
      owner_name: 'Betty',
    	breed_1: rating['breed_1'],
    	breed_2: rating['breed_2'],
    	breeder_responsibility: rating['breeder_responsibility'],
    	overall_health: rating['overall_health'],
    	trainability: rating['trainability'],
    	social_behavior: rating['social_behavior'],
    	energy_level: rating['energy_level'],
    	simpatico_rating: rating['simpatico_rating'],
    	comments: rating['comments'],
    	breeder_id: breeder.id)
  end
end

Given /^(?:|I )am on (.+)/ do |page_name|
	visit path_to(page_name)
end

When /^I select "(.*?)" from "(.*?)"/ do |arg1, arg2|
  page.select arg1, :from => arg2
end


When /^I press "(.*)"/ do |button|
	click_button(button)
end

Then /^I should( not)? see "(.*)"/ do |not_see, text|
	if not_see != nil
		assert page.has_no_content?(text)
  else
		assert page.has_content?(text)
	end	
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

#Given /^I submit the following rating:$/ do |pups_table|
#  pups_table.hashes.each do |rating|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
#    Pup.create(
#      breed_1: rating['breed_1'],
#      breed_2: rating['breed_2'],
#      breeder_responsibility: rating['breeder_responsibility'],
#      overall_health: rating['overall_health'],
#      trainability: rating['trainability'],
#      social_behavior: rating['social_behavior'],
#      energy_level: rating['energy_level'],
#      simpatico_rating: rating['simpatico_rating'],
#      comments: rating['comments'],
#      breeder_id: rating['breeder_id'])
#      fill_in()
#  end
#end

When /^I fill out the form with the following attributes:$/ do |pups_table|
  pups_table.hashes.each do |rating|
    select rating['breed_1'], :from => 'Primary Breed'
    select rating['breed_2'], :from => 'Secondary Breed'
    select rating['breeder_responsibility'], :from => 'Breeder Responsibility'
    select rating['overall_health'], :from =>  'Overall Health'
    select rating['trainability'], :from => 'Trainability'
    select rating['social_behavior'], :from => 'Social Behavior'
    select rating['energy_level'], :from => 'Energy Level'
    select rating['simpatico_rating'], :from => 'Simpatico Rating'
    fill_in 'Comments', :with => rating['comments']
    fill_in 'Pup Name', :with => rating['pup_name']
    fill_in 'Owner Name', :with => rating['owner_name']
  end
end

Given(/^the following breeders exist:$/) do |table|
  table.hashes.each do |breeder|
    Breeder.create!(breeder)
  end
end

When(/^I enter "(.*?)" into "(.*?)"$/) do |value, field|
  fill_in(field, :with => value)
end

When(/^I am( not)? logged in$/) do |not_logged_in|
  User.create!(
    email: 'justin@gmail.com',
    password: 'password'
  )
  @user = User.find_all_by_email('justin@gmail.com')
  if not_logged_in
    assert_equal @user.user_signed_in? false
  else
    assert_equal @user.user_signed_in? true
  end
end