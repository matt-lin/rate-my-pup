ActiveAdmin.register Breed do
  filter :name
  index do
    selectable_column
    column :id
    column :name do |b|
      link_to b.name, admin_breed_path(b)
    end
  end
end
