#
# Here is a cheat sheet to the commands to interact with the webpages
# https://gist.github.com/zhengjia/428105
#
#


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

# Projects Test Steps
Given(/^I am on the projects page$/) do
  visit section_projects_path :section_id => 1
  page.should have_no_content("Capstone Project")
end
		
When(/I click on Add New Project/) do
  click_link('Add New Project')
  visit new_section_project_path :section_id => 1
end

And(/Fill in the project information/) do
  fill_in('Title', :with => "Capstone Project")
  fill_in('Description', :with => "A project focused around the goal of...")
  fill_in('Min Group Size', :with => 5)
  fill_in('Max Group Size', :with => 7)
  #fill_in("project[topics]", :with => "AI,Networking")
  #fill_in('Hardware', :with => true)
  #fill_in('Industry Sponsored', :with => true)
  fill_in('Client', :with => "CSCE Department")
end

And(/Click Create Project/) do
  click_button('Create Project')
end

Then(/A project is created/) do
  visit section_projects_path :section_id => 1
  page.should have_content("Capstone Project")
end
  






