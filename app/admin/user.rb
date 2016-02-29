ActiveAdmin.register User do
  permit_params	:email, :password, :uid, :first_name, :last_name
  form do |f|
    semantic_errors # shows errors on :base
    f.inputs do
      f.input :email
      f.input :password
      f.input :category, as: :select, collection:
      Category.all.map { |c| [c.english_title, c.id] }
      f.input :provider
      f.input :uid, as: :select, collection:
      User.all.map { |e| [e.first_name, e.id] }
      f.input :first_name
      f.input :last_name
    end
    actions
  end
end