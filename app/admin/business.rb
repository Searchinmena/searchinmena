ActiveAdmin.register Business do
  permit_params :name, :phone, :user_id, :no_of_employees, :country_id, :city,
                :feature, :weight, :logo, :logo_tmp, :limit
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
      f.input :feature
      f.input :weight, as: :select, collection: ((0..100).map { |i| [i, i] })
      f.input :limit, as: :select, collection: ((0..100).map { |i| [i, i] })
    end
    actions         # adds the 'Submit' and 'Cancel' buttons
  end
end