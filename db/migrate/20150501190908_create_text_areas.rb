class CreateTextAreas < ActiveRecord::Migration
  def up
    create_table 'texts' do |t|
      t.string 'section_title', :default => ''
      t.integer 'section_order', :default => 0
      t.string 'title', :default => ''
      t.text 'text', :default => ''
    end
  end

  def down
  end
end
