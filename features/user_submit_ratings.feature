@javascript
Feature: only users with a user profile should be able to submit a rating

  As a current dog owner
  So that I can review my dog and be held liable for what I say about my dog or a dog breeder
  I should be logged into my user profile.

  Background: reviews have been added to the database

  Scenario: there should be a login button on the home page

    Given I am on the RateMyPup home page
    Then I should see "Login"
    Then I should see "Signup"
    When I follow "Login"
    Then I should be on the Login page

  Scenario: should not be able to submit a rating if logged in as a user

    Given I am on the RateMyPup home page
    Then I should see "Login"
    Then I press "Rate your Pup"
    Then I should be on the "Create New Pup" page
    When I fill out the form with the following attributes:
      | pup_name           | owner_name      | breed_1            | breed_2         | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments                          | breeder_id        |
      | Tiny               | Justin          | Labrador Retriever | None            | 2                      | 5              | 3            | 4               | 4            | 4                | Easy to train. Excellent dog.     | 2                 |
    And I press "Add Pup"
    Then I should be on the Login page
    And I should see "You need to sign in or sign up before continuing."

  Scenario: should be able to submit a rating if not logged in

    Given I am on the RateMyPup home page
    And I am logged in
    Then I am on the RateMyPup home page
    Then I press "Rate your Pup"
    Then I should be on the "Create New Pup" page
    When I fill out the form with the following attributes:
      | pup_name           | owner_name      | breed_1            | breed_2         | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments                          | breeder_id        |
      | Erik               | Justin          | Golden Retriever   | None            | 2                      | 5              | 3            | 4               | 4            | 4                | My favorite of my three dogs.     | 2                 |
    And I press "Add Pup"
    Then I should see "My favorite of my three dogs."
    And I should see "Justin"
    And I should see "Erik"