Feature: Creating projects
	Scenario: View Projects_Page	
	    Given A test section has been created with the values "CSCE 589" and "500"
	    And I am on the projects page
	    Then I should see "Projects"
	Scenario: Back Button
		Given A test section has been created with the values "CSCE 589" and "500" 
		And I am on the projects page
		When I click on "Back"
		Then I should see "Sections"
	Scenario: Create New Project
	    Given A test section has been created with the values "CSCE 589" and "500" 
	    And I am on the projects page
		When I click on "Add New Project"
		And I fill in the project information
		And I click on the "Create Project" button
		Then I should see "Project was successfully created."
		
	Scenario: Edit A Project
		Given A test section has been created with the values "CSCE 589" and "500" 
		And A test project has been created with a title of "Capstone_project1"
		And I am on the projects page
		When I click on "Edit"
		And I fill in a new "Title" value of "CSCE_Department_Project"
		And I click on the "Save Project" button
		Then I should see "Project was successfully updated"
	Scenario: Destroy A Project
		Given A test section has been created with the values "CSCE 589" and "500" 
		And A test project has been created with a title of "Capstone_project1"
		And I am on the projects page
		When I click on "Destroy"
		Then I should NOT see "Project was successfully updated"
