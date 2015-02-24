Feature: submit new rating for an existing dog breed and breeder

    As a current dog owner
    So that I can review my dog breeder and breed
    I want to be able to add a new review for my dog

Background: reivews have been added to the database

    Given the following reviews have been added to database
    | breed1 			| breed2 		 | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments 						  | breeder 	   |
    | German Short Hair |    			 | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned  | George W. Bush |
    | German Short Hair |    			 | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong | Richard Nixon  |
    | German Short Hair |    			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Very aloof. 					  | Barack Obama   |
    | Vizsla 			|    			 | 5 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned  | George W. Bush |
    | Vizsla 			|    			 | 4 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong | Richard Nixon  |
    | Vizsla 			|    			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Very aloof. 					  | Barack Obama   |
    | Poodle 			| Cocker Spaniel | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned  | George W. Bush |
    | Poodle 			| Cocker Spaniel | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong | Richard Nixon  |
    | Shiba Inu 	  	|    			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Such review. Wow. 				  | Barack Obama   |

    And I am on the RateMyPup home page

Scenario: navigate to review page
    When I press the button "submit new review"
    Then I should be on the "create new review" form

Scenario: submit new review
    Given that I am on the "create new review" form
    And I submit the following review:
    | breed1            | breed2         | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments                          | breeder        |
    | Labradoodle       |                 | 2                      | 5              | 3            | 4               | 4            | 4                | A little hard to train but lovable| James K. Polk  |
    Then the database should include the following review: | Labradoodle       |                 | 2                      | 5              | 3            | 4               | 4            | 4                | A little hard to train but lovable| James K. Polk  |


Scenario: make sure all fields are full
    Given that I am on the "create new review" form
    And I submit the following review: 
    | breed1            | breed2         | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments                          | breeder        |
    | Labradoodle       |                 |                        | 5              | 3            | 4               | 4            | 4                | A little hard to train but lovable| James K. Polk  |
    Then I should see "Please make sure all fields are complete!"
    And I should be on the "create new review" form
    And the database should not include a review for "Labradoodle"

