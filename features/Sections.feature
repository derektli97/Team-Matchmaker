Feature: Sections_Page
	Scenario: Sections page
		Given I am on the sections page
		Then I should see "Sections"
		And I should see "Course - Section"
	Scenario: Create New section Back button
		Given I am on the sections page
		When I click on "New Section"
		And I click on "Back"
		Then I should see "Sections"
		And I should see "Course - Section"
	Scenario: Create New Section
	    Given I am on the sections page
		When I click on "New Section"
		And I fill in the section information with "CSCE 121" and "502"
		And I click on the "Save" button
		Then I should see "Section was successfully created"
		And I should see "CSCE 121 - 502"
	Scenario: Edit a Section
		Given I am on the sections page
		And A test section has been created with the values "CSCE 121" and "500"
		When I click on "Edit"
		And I fill in a new "Section" value of "505"
		And I click on the "Save" button
		Then I should see "Section was successfully updated."
		And I should see "Course: CSCE 121"
		And I should see "Section: 505"
	Scenario: Show a section
		Given I am on the sections page
		And A test section has been created with the values "CSCE 121" and "500"
		When I click on "Edit"
		And I click on "Show"
		Then I should see "Course: CSCE 121"
		And I should see "Section: 500"
#	Scenario: Destroy a section
		
		