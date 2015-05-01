@javascript
Feature: Improve "flow" of site

    As a user
    So I can have a more positive experience on the RateMyPup webpage
    I want to be able to intuitively interact with the site

  Background: breeders have been added to the database
    Given the following breeders exist:
      | name            | city     | state  |
      | Carl            | Berkeley | CA     |
      | Chris           | Berkeley | CA     |
      | Alex            | Richmond | CA     |
      | Alexander       | New York | NY     |
      | Michael Jackson | Boston   | MA     |
      | George Michael  | Fresno   | CA     |
      | George W. Bush  | Waco     | TX     |
    And I am on the RateMyPup home page

    Scenario: More descriptions
      Given I am logged in
      And I am on the "Create New Pup" page
      Then I should see "What do you feel are the most important positive of negative aspects of your dog?"
      And I should see the hashtags