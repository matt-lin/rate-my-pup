class CreateBreeders < ActiveRecord::Migration

  def up
    create_table 'breeders' do |p|

      p.string 'name'
      p.string 'location'
      p.string 'website'

    end
  end

  def down
    drop_table 'breeders'
  end
end
