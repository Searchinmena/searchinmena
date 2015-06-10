class AddTradeInfoToProducts < ActiveRecord::Migration
  def change
    change_table(:products) do |t|
      t.integer :min_order_quantity_number
      t.string  :min_order_quantity_unit
      t.integer :FOB_price
      t.string  :FOB_price_type
      t.string  :FOB_price_unit
      t.string  :port
      t.string  :payment_terms
      t.integer :supply_abbility_number
      t.string  :supply_abbility_type
      t.string  :supply_abbility_capacity
      t.string  :packaging_details
    end
  end
end
