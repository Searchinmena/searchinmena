ActiveAdmin.register Product do
  permit_params :name, :model_number, :brand_name, :category_id,
                :min_order_quantity_number, :min_order_quantity_unit_id,
                :fob_price, :fob_price_currency_id, :fob_price_unit_id,
                :port, :supply_ability_unit_id, :supply_ability_frequency_id,
                :supply_ability_capacity, :business_id
  form do |f|
    semantic_errors # shows errors on :base
    f.inputs do
      f.input :name
      f.input :model_number
      f.input :brand_name
      f.input :description
      f.input :category_id, as: :select, collection:
      Category.all.map { |c| [c.id, c.id] }
      f.input :min_order_quantity_number
      f.input :min_order_quantity_unit_id
      f.input :fob_price
      f.input :fob_price_currency_id
      f.input :fob_price_unit_id
      f.input :port
      f.input :supply_ability_capacity
      f.input :supply_ability_unit_id
      f.input :supply_ability_frequency_id
      f.input :packaging_details
      f.input :business_id, as: :select, collection:
      Business.all.map { |c| [c.name, c.id] }
    end
    actions         # adds the 'Submit' and 'Cancel' buttons
  end
end