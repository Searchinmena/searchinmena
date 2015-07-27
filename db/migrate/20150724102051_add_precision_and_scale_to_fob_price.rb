class AddPrecisionAndScaleToFobPrice < ActiveRecord::Migration
  def change
    change_column :products, :fob_price, :decimal, precision: 17, scale: 2
    change_column :services, :fob_price, :decimal, precision: 17, scale: 2
  end
end
