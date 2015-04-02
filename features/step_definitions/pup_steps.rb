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

Given /^I am on (.+)/ do |page_name|
	visit path_to(page_name)
end

When /^I select "(.*?)" from "(.*?)"/ do |arg1, arg2|
  page.select arg1, :from => arg2
end


When /^I press "(.*)"/ do |button|
	click_button(button)
end

When /^I follow "(.*)"$/ do |link|
  click_link(link)
end

Then /^I should( not)? see "(.*)"/ do |not_see, text|
  if not_see != nil
		assert page.has_no_content?(text)
  else
		assert page.has_content?(text)
	end	
end

Then /^I should be on (.+)$/ do |page_name|
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
    slide('slider-breeder', rating['breeder_responsibility'])
    slide('slider-health', rating['overall_health'])
    slide('slider-train', rating['trainability'])
    slide('slider-social', rating['social_behavior'])
    slide('slider-energy', rating['energy_level'])
    slide('slider-simpatico', rating['simpatico_rating'])
    fill_in 'Comments', :with => rating['comments']
    fill_in 'Pup Name', :with => rating['pup_name']
    fill_in 'Owner Name', :with => rating['owner_name']
  end
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

Given(/^the following breeders exist:$/) do |table|
  table.hashes.each do |breeder|
    FactoryGirl.create(:breeder, :name => breeder[:name])
  end
end

When(/^I enter "(.*?)" into "(.*?)"$/) do |value, field|
  fill_in(field, :with => value)
end

When /^I enter "(.*?)" into autocomplete "(.*?)" with "(.*)"$/ do |value, field, event|
  auto_complete(field, value, event)
end

When(/^I am logged in$/) do
  @user = FactoryGirl.create(:user)
  click_link("Login")
  fill_in(:user_email, :with => "lolright@aol.com")
  fill_in(:user_password, :with => "lolright")
  click_button("Log in")
end


def slide(slidr, value)
  page.execute_script "s=$('#slidr');"
  page.execute_script "s.slider('option', 'value', #{value})"
end

def auto_complete(text_field, value, event='keyup')
  page.execute_script "s = $('##{text_field}');"
  page.execute_script "s.val('#{value}').#{event}();"
end
Given /^a confirmation box saying "(.*)" should pop up$/ do |message|
  @expected_message = message
end

Given /^I want to click "(.*)"$/ do |option|
  retval = (option == "Ok") ? "true" : "false"

  page.evaluate_script("window.confirm = function (msg) {
    $.cookie('confirm_message', msg)
    return #{retval}
  }")
end

Then /^the confirmation box should have been displayed$/ do
  page.evaluate_script("$.cookie('confirm_message')").should_not be_nil
  page.evaluate_script("$.cookie('confirm_message')").should eq(@expected_message)
  page.evaluate_script("$.cookie('confirm_message', null)")
end