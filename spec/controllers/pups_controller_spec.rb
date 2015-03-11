require 'spec_helper'

describe PupsController do
  describe "looking at all pups" do
    it "should get all of the dogs" do
      Pup.should_receive(:all)
      get :index
      response.should render_template 'index'
    end
  end
  describe "page for submitting new review" do
    it "should get all of the breeds for the page" do
      Pup.should_receive(:all_breeds).and_return([])
      Pup.should_receive(:all_breeds_none).and_return([])
      get :new
    end
  end
  describe "serving main page" do
    it "should get all of the breeds for the page" do
      Pup.should_receive(:all_breeds).and_return([])
      Pup.should_receive(:all_breeds_none).and_return([])
      Breeder.should_receive(:all).and_return([])
      get :main
    end
  end
  describe "looking at a single pup review" do
    it "should find the pup" do
      temp_pup = FactoryGirl.build(:pup)
      Pup.should_receive(:find).with('1').and_return(temp_pup)
      get :show, :id => 1
    end
  end
  describe "creating a pup review" do
    it "should create the pup and redirect to all pups" do
      temp_pup = FactoryGirl.build(:pup)
      Pup.should_receive(:create!).with({}).and_return(temp_pup)
      post :create, {:pup => {}}
    end
  end
  describe "updating a review" do
    it "should find the pup and update it's attributes" do
      temp_pup = FactoryGirl.build(:pup)
      Pup.should_receive(:find).with('1').and_return(temp_pup)
      temp_pup.should_receive(:update_attributes).with({})
      put :update, {:id => 1, :pup => {}}
      response.should redirect_to pups_path
    end
  end
  describe "deleting a pup rating" do
    it "should find the pup and destroy it's review" do
      temp_pup = FactoryGirl.build(:pup)
      Pup.should_receive(:find).with('1').and_return(temp_pup)
      temp_pup.should_receive(:destroy)
      delete :destroy, :id => 1
      response.should redirect_to pups_path
    end
  end
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