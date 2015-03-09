Given /the following ratings exist/ do |pups_table|
  pups_table.hashes.each do |rating|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Pup.create(
    	breed_1: rating['breed_1'],
    	breed_2: rating['breed_2'],
    	breeder_responsibility: rating['breeder_responsibility'],
    	overall_health: rating['overall_health'],
    	trainability: rating['trainability'],
    	social_behavior: rating['social_behavior'],
    	energy_level: rating['energy_level'],
    	simpatico_rating: rating['simpatico_rating'],
    	comments: rating['comments'],
    	breeder_id: rating['breeder_id'])
  end
  # flunk "Unimplemented"
end

Given /^(?:|I )am on (.+)$/ do |page_name|
	visit path_to(page_name)
end

When(/^I select "(.*?)" from "(.*?)"$/) do |arg1, arg2|
  page.select arg1, :from => arg2
end


When /^I press "(.*)"/ do |button|
	click_button(button)
end

Then(/^I should see the following average ratings:$/) do |table|
end

Then /^I should( not)? see "(.*)"/ do |not_see, text|
	if not_see
		assert page.has_no_content?(text)
	else
		assert page.has_content?(text)
	end
end

Then(/^I should be on the "(.*?)" page$/) do |arg1|
end

Given(/^I submit the following rating:$/) do |table|
end

Then(/^the database should include the following rating: \| Pug            \|                 \| (\d+)                      \| (\d+)              \| (\d+)            \| (\d+)               \| (\d+)            \| (\d+)                \| A little hard to train but lovable\| James K\. Polk  \|$/) do |arg1, arg2, arg3, arg4, arg5, arg6|
end
