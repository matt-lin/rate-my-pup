Feature: select dog breed using when using rating
  
  As a dog rater
  So that add a rating
  I want to enter a dog breeder
  
  Background: breeds have been added to the database
    
    Given the follow breeds exist:
      | name            |
      | affenpinscher   |
      | afghan hound    |
      | Akita           |

    And I am on select dog breed page


  Scenario: fill in partial of the name
    When I enter "af" in to autocomplete "breed_find" with "keyup"
    Then I should see "affenpinscher"
    And I should see "afghan hound"
    And I should not see "Akita"
    When I follow "affenpinscher"
    And I press "next"
    Then I should be on "breeder_find"

  Scenario: don't know the breed or not finding the breed
    When press "back"
    Then I should be on homepage
    And I should see "We only collect infomation of certain dog breed."
