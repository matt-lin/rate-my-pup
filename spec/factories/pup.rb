FactoryGirl.define do
  factory :pup do
    pup_name 'Doge'
    owner_name 'Curious George'
    association :breeder, factory: :breeder
    breed_1 'shiba inu'
    breeder_responsibility 4
    overall_health 5
    trainability 4
    social_behavior 5
    energy_level 1
    simpatico_rating 5
    comments "Wow. Such doge. Very pup."
  end
end