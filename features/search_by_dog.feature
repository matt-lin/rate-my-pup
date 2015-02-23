Feature: display average rating of breed along with corresponding reviews

	As a prospective dog owner
	So that I can quickly see what characteristics a specific dog has
	I want to be able to search for a specific dog breed's characteristics ratings

Background: reivews have been added to the database

	Given the following reviews have been added to database
	| breed1 						| breed2 								| breeder_responsability | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments 												 | breeder 				|
	| German Short Hair |    										| 4 										 | 5 							| 5 					 | 4 							 | 5 						| 5 							 | The greatest dog I've ever owned  | George W. Bush |
	| German Short Hair |    										| 2 										 | 3 							| 3 					 | 3 							 | 5 						| 4 							 | Incredibly high energy and strong | Richard Nixon 	|
	| German Short Hair |    										| 3 										 | 4 							| 4 					 | 5 							 | 4 						| 2 							 | Very aloof. 											 | Barack Obama 	|
	| Vizsla 					  |    										| 5 										 | 5 							| 5 					 | 4 							 | 5 						| 5 							 | The greatest dog I've ever owned  | George W. Bush |
	| Vizsla 						|    										| 4 										 | 3 							| 3 					 | 3 							 | 5 						| 4 							 | Incredibly high energy and strong | Richard Nixon 	|
	| Vizsla 					  |    										| 3 										 | 4 							| 4 					 | 5 							 | 4 						| 2 							 | Very aloof. 											 | Barack Obama 	|
	| Poodle 					  | Cocker Spaniel 				| 4 										 | 5 							| 5 					 | 4 							 | 5 						| 5 							 | The greatest dog I've ever owned  | George W. Bush |
	| Poodle 					  | Cocker Spaniel 				| 2 										 | 3 							| 3 					 | 3 							 | 5 						| 4 							 | Incredibly high energy and strong | Richard Nixon 	|
	| Shiba Inu 	  	  |    										| 3 										 | 4 							| 4 					 | 5 							 | 4 						| 2 							 | Such review. Wow. 								 | Barack Obama 	|

	And I am on the RateMyPup home page


	Scenario: search for single breed of dog
	When I select the breed "Shiba Inu" from the breeds selector
	And I press "Search"
	Then I should see the following average Ratings:
	| breeder_responsability | overall_health | trainability | social_behavior | energy_level | simpatico_rating |
	| 3 										 | 4 							| 4 					 | 5							 | 4						| 2								 |
	And I should see the following comments for the breed "Shiba Inu":
	| comment 				  |
	| Such review. Wow. |

	Scenario: search for secondary breed of dog
	When I select the following breeds: "Poodle", "American Cocker Spaniel"
	And I press "Search"
	Then I should see the following average Ratings:
	| breeder_responsability | overall_health | trainability | social_behavior | energy_level | simpatico_rating |
	| 3 										 | 4 							| 4 					 | 3.5					 	 | 5						| 4.5 						 |
	And I should see the following comments for the breeds "Poodle" and "Cocker Spaniel":
	| comment 				  							  |
	| The greatest dog I've ever owned  |
	| Incredibly high energy and strong |
