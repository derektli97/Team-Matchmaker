Feature: Preferences
    Scenario: Create new student
      Given A test section has been created with the values "CSCE 589" and "500"
      And I created a test project
      When I visit the new student form page
      And I fill out the new student form
      And I click on the "Submit" button
      Then I should see "Listing students"
