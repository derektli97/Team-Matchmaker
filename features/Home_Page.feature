Feature: Home_Page
	Scenario: View Home_Page
	    Given I am on the home page
	    Then I should see "Team Matchmaker"
	Scenario: Login
	    Given I am on the home page
	    When I click on "LOGIN", I am taken to the "sections" page
	Scenario: User Creation
	    Given I am on the home page
	    When I click on Create Account, I am taken to the New User page