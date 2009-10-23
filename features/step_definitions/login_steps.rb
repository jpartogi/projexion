Given /^I want to login$/ do
  visit login_url 
end

When /^I click the login button$/ do
  #click_button('Login')      
end

Then /^I should see "([^\"]*)" as the title$/ do |result|
  assert_select 'title', result
end
