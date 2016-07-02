class AddTimeOwnedDog < ActiveRecord::Migration
  def change
    add_column :pups, :year, :integer
    add_column :pups, :month, :integer
  end
end
