@javascript
Feature: Split rating process into a few steps
  As a dog owner, when I rate my puppy
  So that I can make sure I am allowed to rate my puppy before I enter too much information
  I want to provide information interactively
  
Background: User already logged in
  Given I am on the RateMyPup home page
  And I am logged in
  
  Scenario: step1: whether owned a puppy over 6 months
    When I follow "Rate your Pup"
    Then I should see "Have you own your puppy longer than 6 months?"
    
  Scenario: if owned a puppy over 6 months, I should on step2: a purebred or not
    When I follow "Rate your Pup"
    And I follow "Yes"
    Then I should see "Is your puppy a purebred or a mix of two known breeds?"
  
  Scenario: if owned a puppy less than 6 months, we do not collect that rating
    When I follow "Rate your Pup"
    And I follow "No"
    Then I should see "We do not collect data for puppies owned less than 6 months"
    
  Scenario: if a purebred
    When I follow "Rate your Pup"
    And I follow "Yes"
    And I follow "Yes"
    Then I should be on the "Create New Pup" page
    
  Scenario: if not a purebred
    When I follow "Rate your Pup"
    And I follow "Yes"
    And I follow "Not"
    Then I should on the RateMyPup home page
    And I should see "We do not collect data for mixed breed puppies"
    
