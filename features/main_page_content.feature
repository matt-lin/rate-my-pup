@javascript
Feature: see content on the main page 

    As a user of RateMyPup
    So that I can use the site 
    I want to be able to see information about it 

Background:
    Given I am on the RateMyPup home page
    And I am logged in

Scenario: information content on main page 
    Given I am on the RateMyPup home page
    Then I should see "Our Mission"
    And I should see "Contact"

Scenario: Hover over buttons should show hidden div 
    Given I am on the RateMyPup home page
    When I click ".button-b"
    Then I should see "Search for ratings by breed:"
    When I click ".button-c"
    Then I should see "Find a breeder or kennel by name or city and state:"

Scenario: Direct to rate your pup 
    Given I am on the RateMyPup home page
    When I follow "Rate your Pup"
    Then I should be on the "Create New Pup" page

