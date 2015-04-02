@javascript
Feature: display average rating of breed along with corresponding reviews

    As a prospective dog owner
    So that I can quickly see what characteristics a specific dog has
    I want to be able to search for a specific dog breed's characteristics ratings

Background: reviews have been added to the database

    Given the following ratings exist:
    | breed_1 			| breed_2 		 | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments 						  | breeder_id 	   |
    | German Short Hair | None 			 | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | 2 |
    | German Short Hair | None 			 | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.| 3  |
    | German Short Hair | None 			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Very aloof. 					  | 1   |
    | Vizsla 			| None 			 | 5 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | 2 |
    | Vizsla 			| None 			 | 4 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.| 3  |
    | Vizsla 			| None 			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Very aloof. 					  | 1   |
    | Poodle 			| Cocker Spaniel | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest poodle ever.         | 2 |
    | Poodle 			| Cocker Spaniel | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Great dog.                        | 3  |
    | Shiba Inu 	  	| None 			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Such review. Wow. 				  | 1   |

    And I am on the RateMyPup home page


Scenario: search for single breed of dog
    When I select "Shiba Inu" from "pup_breed_1"
    And I press "Find a Breed"
    Then I should see "4.0"
    And I should see "Such review. Wow."

Scenario: search for secondary breed of dog
    When I select "Poodle" from "pup_breed_1"
    When I select "Cocker Spaniel" from "pup_breed_2"
    And I press "Find a Breed"
    Then I should see "3.5"
    And I should see "4.5"
    And I should see "The greatest poodle ever."
    And I should see "Great dog."
    And I should not see "Very aloof."
