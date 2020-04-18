#
# Here is a cheat sheet to the commands to interact with the webpages
# https://gist.github.com/zhengjia/428105
#
#



# Global Test Steps
When (/^I click on "(.*?)"$/) do |link|
  click_link(link)
end

When (/^I click on the "(.*?)" button$/) do |button|
  click_button(button)
end

Then(/^I should see "(.*?)"$/) do |text|
  page.should have_content(text)
end

Then(/^I should NOT see "(.*?)"$/) do |text|
  page.should have_no_content(text)
end



# Home Page Test Steps
Given(/^I am on the home page$/) do
  visit root_path
end

When (/^I fill in the account information with "(.*?)" and "(.*?)"$/) do |username, password|
  fill_in('Username', :with => username)
  fill_in('Password', :with => password)
end



# Sections Test Steps
Given(/^I am on the sections page$/) do
  visit sections_path
end

Given (/^A test section has been created with the values "(.*?)" and "(.*?)"$/) do |course, section|
  click_link("New Section")
  fill_in('Course', :with => course)
  fill_in('Section', :with => section)
  click_button("Save")
end

When (/^I fill in the section information with "(.*?)" and "(.*?)"$/) do |course, section|
  fill_in('Course', :with => course)
  fill_in('Section', :with => section)
end

When (/^I fill in a new "(.*?)" value of "(.*?)"$/) do |field, section|
  fill_in(field, :with => section)
end
  


# Projects Test Steps
Given(/^I am on the projects page$/) do
  visit section_projects_path :section_id => 1
end
		
Given(/^A test project has been created with a title of "(.*?)"$/) do |title|
  click_link('Add New Project')
  fill_in('Title', :with => title)
  fill_in('Description', :with => "A project focused around the goal of...")
  fill_in('Min Group Size', :with => 5)
  fill_in('Max Group Size', :with => 7)
  check('Hardware')
  check('Industry Sponsored')
  fill_in('Client', :with => "CSCE Department")
  click_button('Create Project')
end
		
When(/I click on Add New Project/) do
  click_link('Add New Project')
end

When(/I fill in the project information/) do
  fill_in('Title', :with => "Capstone Project")
  fill_in('Description', :with => "A project focused around the goal of...")
  fill_in('Min Group Size', :with => 5)
  fill_in('Max Group Size', :with => 7)
  #check('Algorithms')
  check('Hardware')
  check('Industry Sponsored')
  fill_in('Client', :with => "CSCE Department")
end
