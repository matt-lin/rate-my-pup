Feature: user should provide a username during signup
	As a website admin
	In order to view comment record of each user
	I should use a username field associated with each user

	Scenario: should not be able to submit a rating if not logged in as a user
    Given I am on the Login page
    Then I should see "User name"