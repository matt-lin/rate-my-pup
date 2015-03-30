
@javascript
Feature: autofill breeder name into breeder forms
  As a potential dog owner
  So that I can add a pup to or search by a breeder
  I want to be able to see the breeder name autofill into the form or add a new breeder if it isn't shown

  Background: breeders have been added to the database

    Given the following breeders exist:
      | name            |
      | Carl            |
      | Chris           |
      | Alex            |
      | Alexander       |
      | Michael Jackson |


    And I am on the RateMyPup home page

  Scenario: fill all breeders that start with C
    When I enter "C" into "breeder_entry"
    Then I should see "Chris"
    And I should see "Carl"
    And I should not see "Alex"
    And I should see "Don't see it? Add a new breeder"

  Scenario: fill all breeders that start with a substring
    When I enter "Alex" into "breeder_entry"
    Then I should see "Alex"
    And I should see "Alexander"
    And I should not see "Carl"
    And I should not see "Michael Jackson"
    And I should see "Don't see it? Add a new breeder"

  Scenario: redirect to create new breeder
    When I enter "JMac" into "breeder_entry"
    And I should not see "Carl"
    And I should not see "Michael Jackson"
    And I should see "Don't see it? Add a new breeder"
    When I press "Don't see it? Add a new breeder"
    Then I should be on the "Add breeder" page

