ActiveAdmin.register Business do
  users = User.all.order('email asc')
  cty = Country.all
  permit_params :name, :phone, :user_id, :no_of_employees, :country_id, :city,
                :year_registered, :introduction, :address_line_1, :limit,
                :address_line_2, :logo, :feature, :weight, :remove_logo
  filter :name
  filter :user, collection: proc { users.map { |c| [c.email, c.id] } }
  filter :country, collection: proc { cty.map { |c| [c.english_title, c.id] } }
  filter :phone
  filter :feature

  index do
    selectable_column
    id_column
    column :name
    column :user do |b|
      b.user.email if b.user
    end
    column :country do |b|
      b.country.english_title if b.country
    end
    column :weight
    column :feature
    column :created_at
    actions
  end

  form do |f|
    semantic_errors # shows errors on :base
    f.inputs do
      f.input :name
      f.input :phone
      f.input :user_id, as: :select, collection:
              User.all.map { |c| [c.email, c.id] }
      f.input :year_registered
      f.input :no_of_employees
      f.input :introduction
      f.input :country_id, as: :select, collection:
              Country.all.map { |c| [c.english_title, c.id] }
      f.input :address_line_1
      f.input :address_line_2
      f.input :city
      f.input :logo, as: :file, hint: image_tag(f.object.logo)
      f.input :remove_logo, as: :boolean, required: :false, label: 'Remove Logo'
      f.input :limit, as: :select, collection: ((0..100).map { |i| [i, i] })
      f.input :feature
      f.input :weight, as: :select, collection: ((0..100).map { |i| [i, i] })
    end
    actions         # adds the 'Submit' and 'Cancel' buttons
  end
end