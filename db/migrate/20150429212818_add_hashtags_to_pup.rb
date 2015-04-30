class AddHashtagsToPup < ActiveRecord::Migration
  def change
    remove_column :pups, :hashtag_1
    remove_column :pups, :hashtag_2
    remove_column :pups, :hashtag_3
    add_column :pups, :hashtag_1, :string
    add_column :pups, :hashtag_2, :string
    add_column :pups, :hashtag_3, :string
  end
end
