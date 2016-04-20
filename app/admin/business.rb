ActiveAdmin.register Business do
  users = User.all.order('email asc')
  # cty = Translatable.where(type: :country).all
  permit_params :name, :phone, :user_id, :no_of_employees, :country_id, :city,
                :year_registered, :introduction, :address_line_1, :limit,
                :address_line_2, :logo, :feature, :weight, :remove_logo,
                business_type_ids: [], tag_ids: []
  filter :name
  filter :user, collection: proc { users.map { |c| [c.email, c.id] } }
  # filter :country,collection: proc { cty.map { |c| [c.english_title, c.id] } }
  filter :phone
  filter :feature

  dft_country = nil
  dft_bus_type = nil
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

  show do
    attributes_table do
      row :id
      row :name
      row 'business_type' do |b|
        b.business_types.map(&:english_title).join(', ')
      end
      row :tags do |b|
        b.tags.map.map(&:english_title).join(', ')
      end
      row :phone
      row :user
      row :year_registered
      row :no_of_employees
      row :introduction
      row :address_line_1
      row :address_line_2
      row :city
      row :country do |b|
        b.country.english_title if b.country
      end
      row "Logo" do |m|
        span do
          image_tag(m.logo)
        end
      end
    end
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
      # f.input :business_types, collection:
      # BusinessType.all.map { |c| [c.english_title, c.id] }
      # f.input :tags, collection:
      # Tag.all.map { |c| [c.english_title, c.id] }
      f.input :logo, as: :file, hint: image_tag(f.object.logo)
      f.input :remove_logo, as: :boolean, required: :false, label: 'Remove Logo'
      f.input :limit, as: :select, collection: ((0..100).map { |i| [i, i] })
      f.input :feature
      f.input :weight, as: :select, collection: ((0..100).map { |i| [i, i] })
    end
    actions         # adds the 'Submit' and 'Cancel' buttons
  end

  active_admin_importable do |model, hash|
    if dft_country.nil?
      dft_country = Country.joins(:translations)
                   .where('translations.locale': 'en',
                          'translations.value': 'Saudi Arabia').first
    end

    if dft_bus_type.nil?
      dft_bus_type = BusinessType.joins(:translations)
                     .where('translations.locale': 'en',
                            'translations.value': 'Other').first
    end
    begin
      user = User.find_by_email(hash[:email])
      if user.nil?
        hash[:first_name] ||= '-'
        hash[:last_name] ||= '-'

        user = User.new(first_name: hash[:first_name],
                        last_name: hash[:last_name],
                        email: hash[:email],
                        password: '1234#abcd',
                        password_confirmation: '1234#abcd',
                        category: 0)

        user.skip_confirmation!
        user.save
      end

      if user.persisted? && user.business.nil?
        hash[:phone] ||= '009661234567'
        country = Country.joins(:translations)
                  .where('translations.locale': 'en',
                         'translations.value': hash[:location])

        country = country.present? ? country.first : dft_country
        bus = model.create!(name: hash[:company_name],
                            user_id: user.id,
                            phone: hash[:phone],
                            country_id: country.id,
                            address_line_1: hash[:address_1],
                            address_line_2: hash[:address_2],
                            city: hash[:city],
                            year_registered: hash[:year_registered],
                            no_of_employees: hash[:no_of_employees],
                            introduction: hash[:introduction])

        bus_type = BusinessType.joins(:translations)
                   .where('translations.locale': 'en',
                          'translations.value': hash[:category])

        bus_type = bus_type.present? ? bus_type.first : dft_bus_type
        bus.business_types << bus_type
      end
    rescue
      puts 'skiping record....'
    end
  end
end
