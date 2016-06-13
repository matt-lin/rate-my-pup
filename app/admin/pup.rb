ActiveAdmin.register Pup do
  index do
    column :pup_name
    column :breed do |p|
      auto_link p.breed
    end
    column :breeder do |p|
      auto_link p.breeder
    end
    column :comments do |p|
      auto_link p.comment
    end
    column :breeder_responsibility
    column :overall_health
    column :trainability
    column :social_behavior
    column :energy_level
    column :simpatico_rating
    column :hashtag_1
    column :hashtag_2
    column :hashtag_3
    column :created_at
    column :updated_at
  end

end

# form do |f|
  # f.
# end
