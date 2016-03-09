ActiveAdmin.register Business do
  permit_params :name, :phone, :user_id, :no_of_employees, :country_id, :city,
                :year_registered, :introduction, :address_line_1, :address_line_2,
                :logo, :logo_tmp
  index do
    selectable_column
    id_column
    column :name
    column :phone
    column :year_registered, as: :select, collection:
           Business.all.map { |c| [c.year_registered, c.id] }
    column :user do |b|
      b.user.first_name
    end
    actions
  end
  filter :name, as: :select, collection:
         Business.all.map { |c| [c.name, c.id] }
  filter :country_id, as: :select, collection:
         Country.all.map { |c| [c.english_title, c.id] }
  filter :phone, as: :select, collection:
         Business.all.map { |c| [c.phone, c.id] }
  filter :year_registered, as: :select, collection:
         Business.all.map { |c| [c.year_registered, c.id] }
  filter :user_id, as: :select, collection:
         User.all.map { |c| [c.first_name, c.id] }
  form do |f|
    semantic_errors # shows errors on :base
    f.inputs do
      f.input :name
      f.input :phone
      f.input :user_id, as: :select, collection:
              User.all.map { |c| [c.first_name, c.id] }
      f.input :year_registered
      f.input :no_of_employees
      f.input :introduction
      f.input :country_id, as: :select, collection:
              Country.all.map { |c| [c.english_title, c.id] }
      f.input :address_line_1
      f.input :address_line_2
      f.input :city
      f.input :logo
      f.input :logo_tmp
    end
    actions         # adds the 'Submit' and 'Cancel' buttons
  end
end