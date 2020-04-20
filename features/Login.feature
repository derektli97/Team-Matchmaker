Feature: Login Functionality
	Scenario: View Home_Page
	    Given I am on the home page
	    Then I should see "Team Matchmaker"
	    
	Scenario: User Creation
		Given I am on the home page
		When I click on "Create Account"
		And I fill in the account information with "my_user_name" and "12345678"
		And I click on the "Save" button
		Then I should see "User was successfully created."
		And I should see "Username: my_user_name"
		Then I should see "Password: 12345678"
	Scenario: Login
	    Given I created a test user with "my_user_name" and "12345678"
	    And I am on the home page
	    When I fill in the login information with "my_user_name" and "12345678" 
	    And I click on "LOGIN"
	    Then I should see "Sections"
	Scenario: False Login
		Given I created a test user with "my_user_name" and "12345678"
	    And I am on the home page
	    When I fill in the login information with "not_a_user" and "abcdefg" 
	    And I click on "LOGIN"
	    Then I should NOT see "Sections"
	Scenario: Editing a User after creating an Account
		Given I am on the home page
		When I click on "Create Account"
		And I fill in the account information with "my_user_name" and "12345678"
		And I click on the "Save" button
		And I click on "Edit"
		Then I should see "Editing user"
	    
	Scenario: Create Account button
	    Given I am on the home page
	    When I click on "Create Account"
	    Then I should see "New user"
	Scenario: Create Account Back button
		Given I am on the home page
		When I click on "Create Account"
		And I click on "Back"
		Then I should see "Team Matchmaker"
	Scenario: Back link after creating an Account
		Given I am on the home page
		When I click on "Create Account"
		And I fill in the account information with "my_user_name" and "12345678"
		And I click on the "Save" button
		And I click on "Back"
		Then I should see "Login"
		