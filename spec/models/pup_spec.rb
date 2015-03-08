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
      Rails.logger.info results
      assert(results.member? dog_1)
      assert(results.member? dog_3)
      assert(!results.member?(dog_2))
      assert(!results.member?(dog_4))
      assert(!results.member?(dog_5))
    end
  end
end