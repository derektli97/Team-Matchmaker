Feature: Sections_Page
	Scenario: Create New Section
	    Given I am on the sections page
		When I click on New Section
		And Fill in the section information
		And Click Save
		Then A section is created
	Scenario: Edit Section
	    Given I am on the sections page, and there is a section
	    When I click on Edit section
	    And Change section number to "509"
	    And Click Save
	    Then The section number is changed to "509"