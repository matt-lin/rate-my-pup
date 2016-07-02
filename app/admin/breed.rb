ActiveAdmin.register Breed do
  filter :name
  actions :all, except: [:destroy]
  index do
    column :id
    column :name do |b|
      link_to b.name, admin_breed_path(b)
    end
  end
end
