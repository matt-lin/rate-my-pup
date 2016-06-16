ActiveAdmin.register Pup, as: "Dogs" do
  index do
    column :pup_name
    column :owner do |p|
      auto_link p.user
    end
    column :breed do |p|
      auto_link p.breed
    end
    column :breeder do |p|
      auto_link p.breeder
    end
    column :comments do |p|
      link_to p.comment, admin_user_comment_path(p)
    end
    column :breeder_responsibility
    column :overall_health
    column :trainability
    column :social_behavior
    column :dog_behavior
    column :energy_level
    column :simpatico_rating
    column :hashtag_1
    column :hashtag_2
    column :hashtag_3
    column :created_at
    column :updated_at
    actions
  end
  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    f.actions
  end

  end

