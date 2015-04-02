@javascript
Feature: submit new rating for an existing dog breed and breeder

    As a current owner of a mixed-breed dog
    So that I can provide the most accurate information possible
    I want to be able to accurately state the dog's breed. 

Background:
    Given I am on the RateMyPup home page
    And I am logged in

Scenario: submit new review for single breed dog
    Given I am on the "Create New Pup" page
    When I fill out the form with the following attributes:
    | pup_name           | owner_name      | breed_1            | breed_2         | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments                          | breeder_id        |
    | Thor               | Anna            | Pug                | None            | 2                      | 5              | 3            | 4               | 4            | 4                | A little hard to train but lovable| 4                 |
    And I press "Add Pup"
    And a confirmation box saying "Please provide a rating for your dog only if you are certain that the dog belongs to a recognized breed, or is a mix between two specific recognized breeds. Genetic testing has shown that dogs who appear to be a purebred or a mix of two particular breeds often prove to actually have a very different genetic heritage. To keep our database of breed information as accurate as possible, please submit data only for dogs of known breeding" should pop up
    And I want to click "Ok"
    And I press "OK"
    Then the confirmation box should have been displayed
    And I should be on the "Pups" page
