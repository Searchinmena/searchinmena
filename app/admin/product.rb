ActiveAdmin.register Product do
  filter :category_id, as: :select, collection:
          proc { ProductCategory.all.map { |c| [c.english_title, c.id] } }

  permit_params :category_id, :name, :model_number, :brand_name,
                :min_order_quantity_number, :min_order_quantity_unit_id,
                :fob_price, :fob_price_currency_id, :fob_price_unit_id,
                :port, :supply_ability_unit_id, :supply_ability_frequency_id,
                :supply_ability_capacity, :business_id
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
              Unit.all.map { |c| [c.english_title.join(' '), c.id] }
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
    end
    actions
  end
end