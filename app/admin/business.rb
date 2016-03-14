ActiveAdmin.register Business do
  permit_params :name, :phone, :user_id, :no_of_employees, :country_id, :city,
                :year_registered, :introduction, :address_line_1,
                :address_line_2, :logo
  index do
    selectable_column
    id_column
    column :name, as: :select, collection:
           Business.all.map { |c| [c.name, c.id] }
    column :phone
    column :year_registered, as: :select, collection:
           Business.all.map { |c| [c.year_registered, c.id] }
    column :user do |b|
      b.user.email
    end
    column :country do |b|
      b.country.english_title
    end
    actions
  end
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
    end
    actions         # adds the 'Submit' and 'Cancel' buttons
  end
end