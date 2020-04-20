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



# Login Test Steps
Given(/^I am on the home page$/) do
  visit root_path
end

Given(/I created a test user with "(.*?)" and "(.*?)"$/) do |username, password|
  visit new_user_path
  fill_in('Username', :with => username)
  fill_in('Password', :with => password)
  click_button('Save')
end

When (/^I fill in the account information with "(.*?)" and "(.*?)"$/) do |username, password|
  fill_in('Username', :with => username)
  fill_in('Password', :with => password)
end

When (/^I fill in the login information with "(.*?)" and "(.*?)"$/) do |username, password|
  fill_in('username_Username', :with => username)
  fill_in('password_Password', :with => password)
end




# Sections Test Steps
Given(/^I am on the sections page$/) do
  visit sections_path
end

Given (/^A test section has been created with the values "(.*?)" and "(.*?)"$/) do |course, section|
  visit sections_path
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
  id = Section.all[0].id
  visit section_projects_path :section_id => id
end
		
Given(/^A test project has been created with a title of "(.*?)"$/) do |title|
  id = Section.all[0].id
  visit section_projects_path :section_id => id
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

Given(/^I created a test project/) do
  id = Section.all[0].id
  visit section_projects_path :section_id => id
  click_link('Add New Project')
  fill_in('Title', :with => "Capstone_Project1")
  fill_in('Description', :with => "A project focused around the goal of...")
  fill_in('Min Group Size', :with => 5)
  fill_in('Max Group Size', :with => 7)
  check('Hardware')
  check('Industry Sponsored')
  fill_in('Client', :with => "CSCE Department")
  click_button('Create Project')
end



# Students test steps
When(/I visit the new student form page/) do
  sect = Section.all[0]
  visit new_section_student_path :section_id => sect.id
end

When(/I fill out the new student form/) do
  fill_in("student_first_name", :with => "John")
  fill_in("student_last_name", :with => "Smith")
  fill_in('student_email', :with => "email@gmail.com")
  choose('gender_M')
  choose('ethnicity_Asian')
  # topics
  find_field(id: "tags_", with: "Data Structures").check()
  find_field(id: "tags_", with: "Computer Architecture").check()
  find_field(id: "tags_", with: "Algorithms").check()
  choose('Hardware__Yes')
  # electives
  find_field(id: "electives_", with: "CSCE 411").check()
  find_field(id: "electives_", with: "CSCE 433").check()
  find_field(id: "electives_", with: "CSCE 440").check()
  find_field(id: "electives_", with: "CSCE 470").check()
  find_field(id: "Capstone_Project1_3").choose()
end






And(/I want to save_and_open_page/) do
  save_and_open_page()
end









