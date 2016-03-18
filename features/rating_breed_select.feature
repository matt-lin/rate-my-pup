Feature: select dog breed using when using rating
  
  As a dog rater
  So that add a rating
  I want to enter a dog breed
  
  Background: breeders have been added to the database
    
    Given the follow breeders exist:
      | name            | city     | state |
      | Carl            | Berkeley | CA    |
      | Cart            | Berkeley | CA    |
      | Judy            | Berkeley | CA    |
      | Justin          | Oakland  | CA    |
      | Juke            | San Jose | CA    |
      | Juju            | Berkeley | CA    |
      
    And I am on select dog breed page


  Scenario: fill in partial of the name
    When I enter "ju" in to autocomplete "breeder_find" with "keyup"
    Then I should see "Judy"
    And I should see "Justin"
    Then I should see "Juke"
    Then I should see "Juju"
    And I should not see "Carl"
    When I follow "Juju"
    And I press "next"
    Then I should be on "rating_page"

  Scenario: not finding the breeder, want to add a new breeder
    When I enter "wasd" in to autocomplete "breeder_find" with "keyup"
    And I follow "Don't see it? Add a new breeder"
    Then I should be on "add new breeder page"
    And I press "next"
    Then I should be on "rating_page"
    

  Scenario: don't know the breeder
    When I press "I don't know"
    Then I should be on "rating_page"
    
