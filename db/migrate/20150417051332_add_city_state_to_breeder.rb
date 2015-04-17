class AddCityStateToBreeder < ActiveRecord::Migration
  def change
    add_column :breeders, :city, :string
    add_column :breeders, :state, :string
  end
end
