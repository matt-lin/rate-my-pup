class AddHashtagsToPup < ActiveRecord::Migration
  def change
    add_column :pups, :hashtag_1, :int
    add_column :pups, :hashtag_2, :int
    add_column :pups, :hashtag_3, :int
  end
end
