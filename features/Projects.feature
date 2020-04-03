Feature: Projects_Page
	Scenario: View Projects_Page	
	    Given I am on the projects page
	    Then I should see "Projects"
	Scenario: Back Button
		Given I am on the projects page
		When I click on "Back", I am taken to the "sections" page
	Scenario: Create New Project
	    Given I am on the projects page
		When I click on Add New Project
		And Fill in the project information
		And Click Create Project
		Then A project is created