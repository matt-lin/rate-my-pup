describe Pup do
  describe "searching a dog by breeds" do
    it "should find all dogs with a single breed and no second breed" do
      FactoryGirl.create(:dog)
    end
  end
end