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
	Scenario: Edit A Project
		Given I am on the projects page
		When I click on Edit project
		And Change the title
		And Save the Project
		Then The Project has been edited
	Scenario: Destroy a Project
		Given I am on the projects page
		When I click on Destroy
		And I click OK
		Then The project is destroyed