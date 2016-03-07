@javascript
Feature: Split rating process into a few steps
  As a dog owner, when I rate my puppy
  So that I can make sure I am allowed to rate my puppy before I enter too much information
  I want to provide information interactively
  
Background: User already logged in
  Given I am on the RateMyPup home page
  And I am logged in

  Scenario: step0->1, direct to dog name page
    Given I am on the RateMyPup home page
    When I follow "Rate your Pup"
    Then I should be on the "Dog Name" page
    And I should see "What's your dog's name?"

  Scenario: step1->2(happy), submit form with valid dog name
    Given I am on "Dog Name" page
    When I fill in "dog_name" with "Doggie"
    And I press "next_button"
    Then I should be on "Dog How Long" page
    And I should see "How long have you owned your dog?"

  Scenario: step1->1(sad), submit form with invalid dog name
    Given I am on "Dog Name" page
    When I fill in "dog_name" with ""
    And I press "next_button"
    Then I should be on "Dog Name" page
    And I should see "Please input a name"

  Scenario: step2->3(happy), submit with valid years and months
    Given I am on the "Dog How Long" page
    When I fill in "years" with "1"
    And I fill in "months" with "1"
    And I press "next_button"
    Then I should be on the "Dog Breed" page
    And I should see "Please select a breed for your breed."
  
  Scenario: step2->0(sad), submit form with invalid years and months
    Given I am on the "Dog How Long" page
    When I fill in "years" with "0"
    And I fill in "months" with "4"
    And I press "next_button"
    Then I should be on the RateMyPup home page
    And I should see "Sorry, to keep the information in our database as accurate as possible, we are collecting data only for dogs that have been in the current home for at least six months. Please come back and evaluate your dog later."
    
  Scenario: step3->4(happy), submit with valid breed input
    Given I am on the "Dog Breed" page
    When I select "Affenpinscher" from "breed_selection"
    And I press "next_button"
    Then I should be on the "Dog Breeder" page
    And I should see "Breeder Information"

  Scenario: step3->0(sad), submit with invalid breed input
    Given I am on the "Dog Breed" page
    When I select "I don't know" from "breed_selection"
    And I press "next_button"
    Then I should be on the RateMyPup home page
    And I should see "Sorry, to keep the information in our database as accurate as possible, we are only collecting data for dogs that are members of a recognized AKC breed."

  Scenario: step4->new(happy), submit with either breeder name or kennel name
    Given I am on the "Dog Breeder" page
    When I fill in "breeder_name" with "Redeerb"
    And I fill in "city" with "Berkeley"
    And I fill in "state" with "CA"
    And I press "next_button"
    Then I should be on the "Create New Pup" page
    And I should see "Rate a New Pup"
    
  Scenario: step4->4(sad), submit with empty breeder name and kennel name
    Given I am on the "Dog Breeder" page
    And I press "next_button"
    Then I should be on the "Dog Breeder" page
    And I should see "Enter either breeder's name or the kennel name"
    
