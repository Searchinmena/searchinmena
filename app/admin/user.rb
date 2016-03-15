ActiveAdmin.register User do
  permit_params	:email, :password, :uid, :first_name, :last_name, :provider,
                :category
  filter :email
  filter :category, as: :select, collection: User.categories.keys
  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :category
    actions
  end
  # show do
  #   attributes_table do
  #     row :email
  #     row :first_name
  #     row :last_name
  #     row :provider
  #     row :category
  #   end
  # end
  form do |f|
    semantic_errors # shows errors on :base
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :category, as: :select, collection: User.categories.keys
    end
    actions
  end
end