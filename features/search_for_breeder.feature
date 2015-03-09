Feature: display average rating of breed along with corresponding reviews

    As a prospective dog owner
    So that I can quickly see what owners think of a specific breeder
    I want to be able to search for a specific dog breeder's ratings

Background: reviews have been added to the database

    Given the following ratings have been added to the database
    | breed_1 			| breed_2 		 | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments 						  | breeder 	   |
    | German Short Hair |    			 | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | George W. Bush |
    | German Short Hair |    			 | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.| Richard Nixon  |
    | German Short Hair |    			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Very aloof. 					  | Barack Obama   |
    | Vizsla 			|    			 | 5 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | Super chiller dog.                | George W. Bush |
    | Vizsla 			|    			 | 4 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.| Richard Nixon  |
    | Vizsla 			|    			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Very aloof. 					  | Barack Obama   |
    | Poodle 			| Cocker Spaniel | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | Another great dog.                | George W. Bush |
    | Poodle 			| Cocker Spaniel | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.| Richard Nixon  |
    | Shiba Inu 	  	|    			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Such review. Wow. 				  | Barack Obama   |

    And I am on the "RateMyPup home" page

Scenario: searching for a breeder
    When I select "George W. Bush" from "breeders_breeder_name"
    And I press "Find a Breeder."
    Then I should see the following average ratings:
    | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating |
    | 4.33                   | 5              | 5            | 4               | 5            | 5                |
    And I should see "The greatest dog I've ever owned"
    And I should see "Super chiller dog."
    And I should see "Another great dog."
    And I should not see "Very aloof."
    And I should not see "Incredibly high energy and strong"
    And I should not see "Such review. Wow."
