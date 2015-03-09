require 'spec_helper'

describe PupsController do
  describe "searching a dog by breed" do
    it "should find dogs with the single breed submitted" do
      fake_dogs = [double('pup1'), double('pup2'), double('pup3')]
      Pup.should_receive(:find_by_breeds).with('shiba inu', nil).and_return(fake_dogs)
      avg_ratings = {
        'breeder_responsibility'=> 1,
        'overall_health' => 1,
        'trainability' => 1,
        'social_behavior' => 1,
        'energy_level' => 1,
        'simpatico_rating' => 1
      }
      Pup.should_receive(:avg_ratings_by_breeds).with('shiba inu', nil).and_return(avg_ratings)
      get :breed, {:pup => {:breed_1 => 'shiba inu'}}
    end
    it "should find dogs with two breeds submitted" do
      fake_dogs = [double('pup1'), double('pup2'), double('pup3')]
      Pup.should_receive(:find_by_breeds).with('shiba inu', 'poodle').and_return(fake_dogs)
      avg_ratings = {
          'breeder_responsibility'=> 1,
          'overall_health' => 1,
          'trainability' => 1,
          'social_behavior' => 1,
          'energy_level' => 1,
          'simpatico_rating' => 1
      }
      Pup.should_receive(:avg_ratings_by_breeds).with('shiba inu', 'poodle').and_return(avg_ratings)
      get :breed, {:pup => {:breed_1 => 'shiba inu', :breed_2 => 'poodle'}}
    end
    it "should redirect to the main page when there are no results" do
      Pup.stub(:find_by_breeds).with('shiba inu', 'poodle').and_return([])
      Pup.should_receive(:avg_ratings_by_breeds).never
      get :breed, {:pup => {:breed_1 => 'shiba inu', :breed_2 => 'poodle'}}
      response.should redirect_to root_path
    end
  end
end