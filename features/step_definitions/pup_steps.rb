Given(/^the following ratings have been added to the database$/) do |table|

end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When(/^I select "(.*?)" from "(.*?)"$/) do |arg1, arg2|

end

When(/^I press "(.*?)"$/) do |arg1|

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
