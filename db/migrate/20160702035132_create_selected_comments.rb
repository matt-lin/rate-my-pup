class CreateSelectedComments < ActiveRecord::Migration
  def change
    create_table :selected_comments do |t|
      t.text :content
      t.string :user

      t.timestamps
    end
  end
end
