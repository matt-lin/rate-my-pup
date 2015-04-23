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
    Then I should see "Mission Statement"
    And I should see "Contact"


Scenario: Hover over buttons should show hidden div 
    Given I am on the RateMyPup home page
    When I hover over ".button-b"
    Then I should see "Find a pup breed by type or mix:"
    When I hover over ".button-b"
    Then I should see "Find a pup breeder by name:"

Scenario: Direct to rate your pup 
    Given I am on the RateMyPup home page
    When I click ".button-a"
    Then I should be on the "Create New Pup" page

