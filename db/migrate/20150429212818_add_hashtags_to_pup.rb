class AddHashtagsToPup < ActiveRecord::Migration
  def change
    add_column :pups, :hashtag_1, :string
    add_column :pups, :hashtag_2, :string
    add_column :pups, :hashtag_3, :string
  end
end
