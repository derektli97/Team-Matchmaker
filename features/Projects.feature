Feature: Projects_Page
	Scenario: View Projects_Page	
	    Given I am on the projects page
	    Then I should see "Projects"
	Scenario: Back Button
		Given I am on the projects page
		When I click on "Back"
		Then I should see "Sections"
	Scenario: Create New Project
	    Given I am on the projects page
		When I click on "Add New Project"
		And I fill in the project information
		And I click on the "Create Project" button
		Then I should see "Project was successfully created."
		
	Scenario: Edit A Project
		Given I am on the projects page
		And A test project has been created with a title of "Capstone_project1"
		When I click on "Edit"
		And I fill in a new "Title" value of "CSCE_Department_Project"
		And I click on the "Save Project" button
		Then I should see "Project was successfully updated"
#	Scenario: Destroy a Project
