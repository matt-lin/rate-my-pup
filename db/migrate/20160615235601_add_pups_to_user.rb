class AddPupsToUser < ActiveRecord::Migration
  def change
    add_column :pups, :user_id, :integer
  end
end
