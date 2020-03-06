Given(/^I am on the home page$/) do
  visit "/"
end

Then(/^I should see "(.*?)"$/) do |text|
  page.has_selector?(text)
end