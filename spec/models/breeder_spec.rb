require 'spec_helper'

describe Breeder do
  describe "getting average rating of a breeder" do
    before do
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
end