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
  visit sections_path
  page.has_content?("Edit")
end

When(/I click on Edit section/) do
  click_link('Edit')
end

And(/Change section number to 509/) do
  fill_in('Section', :with => "")
  fill_in('Section', :with => "509")
end

Then(/The section number is changed to "509"/) do
  visit sections_path
  page.shoud have_content('509')
  page.should have_no_content('500')
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
  check('Algorithms')
  check('Hardware')
  check('Industry Sponsored')
  fill_in('Client', :with => "CSCE Department")
end

And(/Click Create Project/) do
  click_button('Create Project')
end

Then(/A project is created/) do
  visit section_projects_path :section_id => 1
  page.should have_content("Capstone Project")
  page.should have_content("A project focused around the goal of...")
end

When(/I click on Edit project/) do
  click_link('Edit')
end

And(/Change the title/) do
  fill_in('Title', :with => "")
  fill_in('Title', :with => "Team Matchmaker")
end

And(/Save the Project/) do
  click_button('Save Project')
end

Then(/The Project has been edited/) do
  visit section_projects_path :section_id => 1
  page.should have_content('Team Matchmaker')
  page.should have_no_content('Capstone Project')
end

When(/I click on Destroy/) do
  click_link('Destroy')
end

And(/I click OK/) do
  click_button('OK')
end

Then(/The project is destroyed/) do
  visit section_projects_path :section_id => 1
  page.should have_no_content('Test')
end




