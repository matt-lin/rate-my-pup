@javascript
Feature: submit new rating for an existing dog breed and breeder

    As a current dog owner
    So that I can review my dog 
    I want to easily know how to submit a correct rating

Background: reviews have been added to the database


Scenario: see the rating descriptions
    Given I am on the "Create New Pup" page
    
    Then I should see "Responsible dog breeders screen their breeder dogs for breed-related genetic problems, provide a health guarantee and ongoing support for the puppies they sell, and provide excellent health care and quality of life for their breeding dogs, even after the dogs are done with breeding. We recommend that you ask any dog breeder about their policies before buying a puppy from them. Please rate the breeder of your dog for the level of responsibility they demonstrated."

    And I should see "Please rate your dog's overall health in the time that you have had him/her. Please do not consider health problems that were the result of accidental injuries, since these are beyond the breeder's control."

    And I should see "Please rate how easy your dog has been to train: consider housetraining, obedience training, and basic manners."

    And I should see "Most people want companion dogs that are friendly and non-aggressive in social situations toward adults, children, and other dogs, and pets. Please rate your dog's social response to others."

    And I should see "Some dogs require a lot of physical exercise to keep them happy and calm, whereas others are content to sleep most of the day. Please rate your dog's overall energy level and exercise requirement at maturity (1--7 years of age)"

    And I should see "Some dogs just seem to have what it takes to be the ultimate companion to 'their' human. These dogs have the desire to please, the ability to communicate, an attitude of attentiveness, and the capacity to forge a relationship based on mutual respect and affection. We call these dogs Simpatico Dogs. Please give your dog an overall Simpatico rating, based on the overall compatibility that your dog has and the depth of the relationship you share."

