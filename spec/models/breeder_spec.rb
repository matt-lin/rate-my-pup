require 'spec_helper'

describe Breeder do
  describe "getting average rating of a breeder" do
    before :each do
      @breeder = FactoryGirl.create(:breeder)
      pups = 10.times.collect  { |i| FactoryGirl.create(:pup, :breeder_id => @breeder.id)}
      @breeder.pups.should == pups
    end
    it "should get the average ratings for each pup" do
      results_hash = {:overall_health => 1, :trainability => 1, :social_behavior => 1,
                      :energy_level => 1, :simpatico_rating => 1, :breeder_responsibility => 1}
      @breeder.pups.each do |pup|
        results_hash.each{|k,v| pup.should_receive(k).and_return(1)}
      end
      @breeder.avg_pup_rating.should == results_hash
    end
  end
  describe "find or create breeder by name nad location" do
    it "should not create new breeder" do
      breeder = FactoryGirl.create(:breeder, :name => "Mcgoo", :location => "94704")
      Breeder.find_or_create("Mcgoo", "94704").should == breeder
    end
    it "should create new breeder" do
      breeder = Breeder.find_or_create("Jmac", "94704", "www.jmac.com")
      Breeder.where(:name => "Jmac").first.should == breeder
    end
  end
  describe "find all matching breeders" do
    before :each do
      @breeders = (1..10).map { |i| FactoryGirl.create(:breeder) }
      @other_breeders = (1..5).map { |i| FactoryGirl.create(:breeder, :name => "Tedus") }
    end
    it "should find all the breeders input into database" do
      Breeder.find_by_substring("Ted").should == @breeders + @other_breeders
    end
    it "should only return 5 breeders input" do
      breeders = Breeder.find_by_substring("Ted", 5)
      breeders.each do |breeder|
        assert(@breeders.include?(breeder) || @other_breeders.include?(breeder), "Breeder not in those created")
      end
      breeders.size.should == 5
    end
    it "should only find the 'Teddy' breeders" do
      Breeder.find_by_substring("Teddy", 0).each do |breeder|
        assert(@breeders.include?(breeder), "Breeder not in the 'Teddy' breeders array")
      end
    end
  end
end