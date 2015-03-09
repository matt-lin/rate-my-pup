require 'spec_helper'

describe Pup do
  describe "should search a dog by breeds" do
    it "should find all dogs with a single breed and no second breed" do
      dog_1 = FactoryGirl.create(:pup, :breed_2 => 'poodle')
      dog_2 = FactoryGirl.create(:pup)
      dog_3 = FactoryGirl.create(:pup, :breed_2 => 'poodle')
      dog_4 = FactoryGirl.create(:pup, :breed_2 => 'German Short Hair')
      dog_5 = FactoryGirl.create(:pup)
      results = Pup.find_by_breeds('shiba inu')
      assert(results.member?(dog_2))
      assert(results.member?(dog_5))
      assert(!results.member?(dog_1))
      assert(!results.member?(dog_4))
      assert(!results.member?(dog_3))
    end
    it "should find all dogs with both breeds and not with only 1 of the breeds" do
      dog_1 = FactoryGirl.create(:pup, :breed_2 => 'poodle')
      dog_2 = FactoryGirl.create(:pup)
      dog_3 = FactoryGirl.create(:pup, :breed_2 => 'poodle')
      dog_4 = FactoryGirl.create(:pup, :breed_2 => 'German Short Hair')
      dog_5 = FactoryGirl.create(:pup)
      results = Pup.find_by_breeds('shiba inu', 'poodle')
      assert(results.member? dog_1)
      assert(results.member? dog_3)
      assert(!results.member?(dog_2))
      assert(!results.member?(dog_4))
      assert(!results.member?(dog_5))
    end
  end
  describe "should find the average ratings for a dog breed" do
    it "should find the average ratings is 0 if there are no matching breeds in db" do
      dog_1 = FactoryGirl.create(:pup, :breed_2 => 'poodle')
      dog_2 = FactoryGirl.create(:pup)
      dog_3 = FactoryGirl.create(:pup, :breed_2 => 'poodle')
      dog_4 = FactoryGirl.create(:pup, :breed_2 => 'German Short Hair')
      dog_5 = FactoryGirl.create(:pup)
      ratings_hash = Pup.avg_ratings_by_breeds('poodle', nil)
      ratings_hash.each do |rating, value|
        assert(value == 0)
      end
    end
    it "should find the correct average ratings for a single breed dog" do
      dog_1 = FactoryGirl.create(:pup, :breed_1 => 'boxer', :trainability => 3)
      dog_2 = FactoryGirl.create(:pup)
      dog_3 = FactoryGirl.create(:pup, :breed_1 => 'boxer', :overall_health => 4)
      dog_4 = FactoryGirl.create(:pup, :breed_1 => 'boxer')
      dog_5 = FactoryGirl.create(:pup)
      ratings_hash = Pup.avg_ratings_by_breeds('boxer', nil)
      correct_hash = {:overall_health => 2, :trainability => 5.0/3.0, :social_behavior => 1,
                      :energy_level => 1, :simpatico_rating => 1}
      assert(correct_hash == ratings_hash)
    end
    it "should find the average ratings for a mixed breed dog" do
      dog_1 = FactoryGirl.create(:pup, :breed_2 => 'poodle')
      dog_2 = FactoryGirl.create(:pup)
      dog_3 = FactoryGirl.create(:pup, :breed_2 => 'poodle')
      dog_4 = FactoryGirl.create(:pup, :breed_2 => 'German Short Hair')
      dog_5 = FactoryGirl.create(:pup)
      ratings_hash = Pup.avg_ratings_by_breeds('poodle', 'shiba inu')
      ratings_hash.each do |rating, value|
        assert(value == 1)
      end
    end
  end
end