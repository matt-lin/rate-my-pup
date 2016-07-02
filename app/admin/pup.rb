ActiveAdmin.register Pup, as: "Dogs" do
  filter :user
  filter :breeder
  filter :breed
  filter :pup_name
  filter :created_at

  index do
    column :id
    column :name do |p|
      link_to p.pup_name, admin_dog_path(p)
    end
    column :year
    column :month
    column :owner do |p|
      auto_link p.user
    end
    # column :
    column :breed do |p|
      auto_link p.breed
    end
    column "Breeder" do |p|
      link_to p.breeder.name, admin_breeder_path(p.breeder)
    end
    column "City" do |p|
      auto_link p.breeder.city
    end
    column "State" do |p|
      auto_link p.breeder.state
    end
    column :comment do |p|
      p.comment.content
    end

    # column :breeder_responsibility
    # column :overall_health
    # column :trainability
    # column :social_behavior
    # column :dog_behavior
    # column :energy_level
    # column :simpatico_rating
    # column :hashtag_1
    # column :hashtag_2
    # column :hashtag_3
    # column :created_at
    # column :updated_at
  end
  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    f.actions
  end

  end

