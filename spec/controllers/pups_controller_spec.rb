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
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in :user, @user
      @temp_pup = FactoryGirl.build(:pup)
      @breeder = FactoryGirl.create(:breeder)
      @pup_hash = {:pup =>
         {
          :breeder_id.to_s => @breeder.id.to_s,
          :breeder_responsibility.to_s => 4.to_s,
          :pup_name.to_s => "Doge",
          :owner_name.to_s => "Curious George",
          :breed_1.to_s => "Shiba Inu",
          :breed_2.to_s => "None",
          :overall_health.to_s => 1.to_s,
          :trainability.to_s => 1.to_s,
          :social_behavior.to_s => 1.to_s,
          :energy_level.to_s => 5.to_s,
          :simpatico_rating.to_s => 5.to_s,
          :comments.to_s => "DOPE CITY"
        }
      }
    end
    it "should redirect to new pup page if fields are incomplete" do
      post :create, {:pup => {:overall_health => ''}}
      response.should redirect_to new_pup_path
    end
    it "should redirect to all pups page if correct fields are input" do
      Pup.should_receive(:new).with(@pup_hash[:pup]).and_return(@temp_pup)
      @temp_pup.should_receive(:save).and_return(true)
      post :create, @pup_hash
      response.should redirect_to "http://test.host/breed?pup%5Bbreed_1%5D=shiba+inu&pup%5Bbreed_2%5D=None"
    end
    it "should redirect to create breeder page if no breeder" do
      @pup_hash[:pup]["breeder_id"] = -1.to_s
      post :create, @pup_hash
      response.should redirect_to new_breeder_path
      session[:pup].should == @pup_hash[:pup]
    end
  end
  describe "updating a review" do
    it "should find the pup and update it's attributes" do
      @user = FactoryGirl.create(:user)
      sign_in :user, @user
      temp_pup = FactoryGirl.build(:pup)
      Pup.should_receive(:find).with('1').and_return(temp_pup)
      temp_pup.should_receive(:update_attributes).with({})
      put :update, {:id => 1, :pup => {}}
      response.should redirect_to pups_path
    end
  end
  describe "deleting a pup rating" do
    it "should find the pup and destroy it's review" do
      @user = FactoryGirl.create(:user)
      sign_in :user, @user
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