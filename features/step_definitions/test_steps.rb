Given(/^I am on the home page$/) do
  visit root_path
end

Then(/^I should see "(.*?)"$/) do |text|
  page.has_content?(text)
end

When (/^I click on "(.*?)", I am taken to the "(.*?)" page$/) do |link,page|
  click_link(link)
  visit page
end

When (/^I click on Create Account, I am taken to the New User page$/) do
  click_link('Create Account')
  visit new_user_path
end

Given(/^I am on the sections page$/) do
  visit sections_path
end

When(/I click on New Section/) do
  click_link('New Section')
  visit new_section_path
end

And(/Fill in the section information/) do
  fill_in('Course', :with => "CSCE 431")
  fill_in('Section', :with => "500")
end

And(/Click Save/) do
  click_button('Save')
end

Then(/A section is created/) do
  page.has_content?('CSCE 431')
  page.has_content?('500')
end

Given(/I am on the sections page, and there is a section/) do
  #page.has_content?()
end

# Create_Account Test Steps
Given(/^I am on the create account page$/) do
  visit new_user_path
end


