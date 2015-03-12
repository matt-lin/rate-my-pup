require 'spec_helper'

describe BreedersController do
  describe "searching by breeder" do
    it "should find dogs for a breeder by name" do
      breeder = FactoryGirl.build(:breeder)
      dogs = (1..10).map do |i|
        FactoryGirl.build(:pup, :breeder_id => breeder.id)
      end
      Breeder.should_receive(:find_by_name).with("Teddy Roosevelt").and_return(breeder)
      breeder.stub(:pups).and_return(dogs)
      get :search_name, {:breeders => {:breeder_name => "Teddy Roosevelt"}}
    end
    it "should redirect to main page if breeder doesn't exist" do
      Breeder.should_receive(:find_by_name).with("Erik Bartlett").and_return(nil)
      get :search_name, {:breeders =>{:breeder_name => "Erik Bartlett"}}
      response.should redirect_to root_path
    end
  end
end
