class AddTimeStampsToPups < ActiveRecord::Migration
  def change
    add_column(:pups, :created_at, :datetime)
    add_column(:pups, :updated_at, :datetime)
  end
end
