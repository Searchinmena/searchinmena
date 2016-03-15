ActiveAdmin.register Service do
  permit_params	:name, :place_of_origin, :scope_of_work, :description,
                :category_id, :fob_price, :fob_price_currency_id,
                :fob_price_unit_id, :port, :average_completion_time,
                :average_completion_time_unit_id, :supply_ability_capacity,
                :supply_ability_unit_id, :supply_ability_frequency_id,
                :business_id, :packaging_details,
                photos_attributes: [:photo, :id, :_destroy]
  index do
    selectable_column
    id_column
    column :name
    column :place_of_origin
    column :scope_of_work
    column :fob_price
    actions
  end
  show do
    attributes_table do
      row :id
      row :name
      row :place_of_origin
      row :scope_of_work
      row :category_id do |b|
        b.category.english_title if b.category
      end
      row :business_id do |b|
        b.business.name if b.business
      end
      row :description
      row :fob_price
      row :fob_price_currency_id do |b|
        b.fob_price_currency.english_title if b.fob_price_currency
      end
      row :fob_price_unit_id do |b|
        b.fob_price_unit.english_title if b.fob_price_unit
      end
      row :port
      row :supply_ability_capacity
      row :supply_ability_unit_id do |b|
        b.supply_ability_unit.english_title if b.supply_ability_unit
      end
      row :supply_ability_frequency_id do |b|
        b.supply_ability_frequency.english_title if b.supply_ability_frequency
      end
      row :average_completion_time
      row :average_completion_time_unit_id do |b|
        if b.average_completion_time_unit
          b.average_completion_time_unit.english_title
        end
      end
      row :packaging_details
      row "Images" do |m|
        m.photos.each do |img|
          span do
            image_tag(img.photo.url(:thumb))
          end
        end
      end
    end
  end
  form do |f|
    semantic_errors # shows errors on :base
    f.inputs do
      f.input :business_id, as: :select, collection:
               Business.all.map { |c| [c.name, c.id] }
      f.input :category_id, as: :select, collection:
               ServiceCategory.all.map { |c| [c.english_title, c.id] }
      f.input :name
      f.input :place_of_origin
      f.input :scope_of_work
      f.input :description
      f.input :fob_price
      f.input :fob_price_currency_id, as: :select, collection:
               Currency.all.map { |c| [c.english_title, c.id] }
      f.input :fob_price_unit_id, as: :select, collection:
               Unit.all.map { |c| [c.english_title, c.id] }
      f.input :port
      f.input :average_completion_time
      f.input :average_completion_time_unit_id, as: :select, collection:
               Unit.all.map { |c| [c.english_title, c.id] }
      f.input :supply_ability_capacity
      f.input :supply_ability_unit_id, as: :select, collection:
              Unit.all.map { |c| [c.english_title, c.id] }
      f.input :supply_ability_frequency_id, as: :select, collection:
              Frequency.all.map { |c| [c.english_title, c.id] }
      f.input :packaging_details
      f.has_many :photos do |p|
        p.input :photo, as: :file, label: "Image", hint:
                p.template.image_tag(p.object.photo.url(:thumb))
        p.input :_destroy, as: :boolean, required: false, label: "remove photo"
      end
    end
    actions         # adds the 'Submit' and 'Cancel' buttons
  end
end