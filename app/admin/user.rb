ActiveAdmin.register User do
  filter :username
  filter :created_at
  filter :last_sign_in_at
end
