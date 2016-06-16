class AddDogBehaviorRating < ActiveRecord::Migration
  def change
    add_column :pups, :dog_behavior, :integer
  end
end
