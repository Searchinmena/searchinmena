class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name, null: false, index: true
      t.string :place_of_origin
      t.text :scope_of_work
      t.string :description
      t.integer :category_id, index: true
      t.decimal :fob_price
      t.integer :fob_price_currency_id, index: true
      t.integer :fob_price_unit_id, index: true
      t.string :port
      t.integer :average_completion_time
      t.integer :average_completion_time_unit_id, index: true
      t.integer :supply_ability_capacity
      t.integer :supply_ability_unit_id, index: true
      t.integer :supply_ability_frequency_id, index: true
      t.string :packaging_details
      t.integer :business_id, null: false, index: true

      t.timestamps null: false
    end
  end
end
