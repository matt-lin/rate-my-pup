class AddDeletedReviewToBreeder < ActiveRecord::Migration
  def change
    add_column :breeders, :removed_reviews, :int, :default => 0
  end
end
