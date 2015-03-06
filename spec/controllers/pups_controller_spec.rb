require 'spec_helper'

describe PupsController do
  describe "finding reviews for a specific breed" do
    it "should find dogs with the single breed submitted" do
      fake_dogs = [double('pup1'), double('pup2'), double('pup3')]
      Pup.should_receive(:find_by_breed).with('shiba inu').and_return(fake_dogs)
      avg_ratings = {
        'breeder_responsibility'=> 1,
        'overall_health' => 1,
        'trainability' => 1,
        'social_behavior' => 1,
        'energy_level' => 1,
        'simpatico_rating' => 1
      }
      Pup.should_receive(:avg_ratings_by_breed).with('shiba inu').and_return(avg_ratings)
      get :breed, {:breed1 => 'shiba inu'}
    end
  end
end