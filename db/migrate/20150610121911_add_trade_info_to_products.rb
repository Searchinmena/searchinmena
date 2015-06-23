class AddTradeInfoToProducts < ActiveRecord::Migration
  def change
    change_table(:products) do |t|
      t.integer :min_order_quantity_number
      t.string  :min_order_quantity_unit
      t.decimal :fob_price
      t.string  :fob_currency
      t.string  :fob_price_unit
      t.string  :port
      t.string  :payment_terms
      t.integer :supply_ability_capacity
      t.string  :supply_ability_unit
      t.string  :supply_ability_frequency
      t.string  :packaging_details
    end
  end
end
