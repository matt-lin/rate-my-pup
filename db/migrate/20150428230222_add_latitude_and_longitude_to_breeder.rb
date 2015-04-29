class AddLatitudeAndLongitudeToBreeder < ActiveRecord::Migration
  def change
    add_column :breeders, :latitude, :float
    add_column :breeders, :longitude, :float
  end
end
