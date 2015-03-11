require 'spec_helper'

describe BreedersController do
  describe "searching by breeder" do
    it "should find dogs for a breeder by name" do
      breeder = FactoryGirl.build(:breeder)
      dogs = 10.times {FactoryGirl.build(:pup, :breeder_id => breeder.id)}
      Breeder.should_receive(:find_by_name).with("Teddy Roosevelt").and_return(breeder)
      breeder.should_receive(:pups).and_return(dogs)
      get :search_name, {:breeder_name => "Teddy Roosevelt"}
    end
    it "should redirect to main page if breeder doesn't exist" do
      Breeder.should_receive(:find_by_name).with("Erik Bartlett").and_return(nil)
      get :search_name, {:breeder_name => "Erik Bartlett"}
      response.should redirect_to root_path
    end
  end
end
