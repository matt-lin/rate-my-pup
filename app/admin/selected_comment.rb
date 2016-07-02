ActiveAdmin.register SelectedComment do
  filter :none
  index do
    column :content
    column :user
    actions
  end
end