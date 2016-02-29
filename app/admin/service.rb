ActiveAdmin.register Service do
  permit_params	:name, :place_of_origin, :scope_of_work, :description,
                :category_id, :fob_price, :fob_price_currency_id,
                :fob_price_unit_id, :port, :average_completion_time,
                :average_completion_time_unit_id, :supply_ability_capacity,
                :supply_ability_unit_id, :supply_ability_frequency_id,
                :business_id
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
    end
    actions         # adds the 'Submit' and 'Cancel' buttons
  end
end