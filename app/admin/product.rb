ActiveAdmin.register Product do
  permit_params :category_id, :name, :model_number, :brand_name,
                :min_order_quantity_number, :min_order_quantity_unit_id,
                :fob_price, :fob_price_currency_id, :fob_price_unit_id,
                :port, :supply_ability_unit_id, :supply_ability_frequency_id,
                :supply_ability_capacity, :business_id, :description,
                :packaging_details, photos_attributes: [:photo, :id, :_destroy]
  filter :name
  filter :business, collection: proc { Business.all.order('name asc') }
  index do
    selectable_column
    id_column
    column :name
    column :brand_name
    column :category do |b|
      b.category.english_title if b.category
    end
    column :business do |b|
      b.business.name if b.business
    end
    column :feature do |b|
      b.business.feature if b.business
    end
    actions
  end
  show do
    attributes_table do
      row :id
      row :name
      row :model_number
      row :brand_name
      row :category_id do |b|
        b.category.english_title if b.category
      end
      row :business_id do |b|
        b.business.name if b.business
      end
      row :description
      row :min_order_quantity_number
      row :min_order_quantity_unit_id do |b|
        b.min_order_quantity_unit.english_title if b.min_order_quantity_unit
      end
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
      f.input :category_id,
              as: :select, collection:
              ProductCategory.all.map { |c| [c.english_title, c.id] }
      f.input :business_id, as: :select, collection:
              Business.all.map { |c| [c.name, c.id] }
      f.input :name
      f.input :model_number
      f.input :brand_name
      f.input :description
      f.input :min_order_quantity_number
      f.input :min_order_quantity_unit_id, as: :select, collection:
              Unit.all.map { |c| [c.english_title, c.id] }
      f.input :fob_price
      f.input :fob_price_currency_id, as: :select, collection:
              Currency.all.map { |c| [c.english_title, c.id] }
      f.input :fob_price_unit_id, as: :select, collection:
              Unit.all.map { |c| [c.english_title, c.id] }
      f.input :port
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
      actions
    end
  end
end