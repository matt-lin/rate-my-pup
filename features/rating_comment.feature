@javascript
Feature: only users with a user profile should be able to submit a rating

  As a current dog owner
  So that I can review my dog and be held liable for what I say about my dog or a dog breeder
  I should be logged into my user profile.

  Background: reviews have been added to the database
    
  Scenario: should limit comments to 140 words

    Given I am on the RateMyPup home page
    And I am logged in
    And I follow "Rate your Pup"
    Then I should be on the "Create New Pup" page
    When I fill out the form with the following attributes:
      | pup_name           | owner_name      | breed_1            | breed_2         | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating   | breeder_id        |
      | Erik               | Justin          | Golden Retriever   | None            | 2                      | 5              | 3            | 4               | 4            | 4                  | 2                 |
    When I fill out the form with the following attributes:
      | comments
      | asdfadsfadfadfdasfasdfsdfdsafadsfldsjfwelighoqeijro;wejriwejigo;wkngklerknfladknflaksndflksadfmlaksflasnflkasdnfaskdnfaksjldfnkadsfnadklsflasfla.
    And I press "Add Pup"
    Then I should see "comments should be no longer than 140 words"