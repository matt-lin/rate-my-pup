Feature: submit new rating for an existing dog breed and breeder

    As a current dog owner
    So that I can review my dog breeder and breed
    I want to be able to add a new review for my dog

Background: reviews have been added to the database

    Given the following ratings exist:
    | breed_1 			| breed_2 		 | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments 						  | breeder_id 	   |
    | German Short Hair |    			 | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | 2 |
    | German Short Hair |    			 | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.| 3  |
    | German Short Hair |    			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Very aloof. 					  | 1   |
    | Vizsla 			|    			 | 5 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | 2 |
    | Vizsla 			|    			 | 4 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.| 3  |
    | Vizsla 			|    			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Very aloof. 					  | 1   |
    | Poodle 			| Cocker Spaniel | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | 2 |
    | Poodle 			| Cocker Spaniel | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.| 3  |
    | Shiba Inu 	  	|    			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Such review. Wow. 				  | 1   |

    And I am on the "RateMyPup home" page

Scenario: navigate to review page
    When I press "Rate your Pup"
    Then I should be on the "Create New Pup" page

Scenario: submit new review
    Given I am on the "Create New Pup" page
    And I submit the following rating:
    | breed_1            | breed_2         | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments                          | breeder        |
    | Pug                |                 | 2                      | 5              | 3            | 4               | 4            | 4                | A little hard to train but lovable| James K. Polk  |
    Then the database should include the following rating: | Pug            |                 | 2                      | 5              | 3            | 4               | 4            | 4                | A little hard to train but lovable| James K. Polk  |

Scenario: make sure all fields are full
    Given I am on the "Create New Pup" page
    And I submit the following rating:
    | breed_1            | breed_2         | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments                          | breeder        |
    | Pug                |                 |                        | 5              | 3            | 4               | 4            | 4                | A little hard to train but lovable| James K. Polk  |
    Then I should see "Please make sure all fields are complete!"
    And I should be on the "Create New Pup" page
