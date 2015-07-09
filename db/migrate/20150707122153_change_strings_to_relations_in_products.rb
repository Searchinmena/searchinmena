class ChangeStringsToRelationsInProducts < ActiveRecord::Migration
  def up
    change_column :products, :fob_price_currency, "integer USING CAST(fob_price_currency AS integer)"
    rename_column :products, :fob_price_currency, :fob_price_currency_id

    change_column :products, :fob_price_unit, "integer USING CAST(fob_price_unit AS integer)"
    rename_column :products, :fob_price_unit, :fob_price_unit_id

    change_column :products, :supply_ability_unit, "integer USING CAST(supply_ability_unit AS integer)"
    rename_column :products, :supply_ability_unit, :supply_ability_unit_id

    change_column :products, :supply_ability_frequency, "integer USING CAST(supply_ability_frequency AS integer)"
    rename_column :products, :supply_ability_frequency, :supply_ability_frequency_id

    change_column :products, :min_order_quantity_unit, "integer USING CAST(min_order_quantity_unit AS integer)"
    rename_column :products, :min_order_quantity_unit, :min_order_quantity_unit_id

    add_index :products, :fob_price_currency_id
    add_index :products, :fob_price_unit_id
    add_index :products, :supply_ability_unit_id
    add_index :products, :supply_ability_frequency_id
    add_index :products, :min_order_quantity_unit_id

    add_index :products, :name
  end

  def down
    remove_index :products, :fob_price_currency_id
    remove_index :products, :fob_price_unit_id
    remove_index :products, :supply_ability_unit_id
    remove_index :products, :supply_ability_frequency_id
    remove_index :products, :min_order_quantity_unit_id

    remove_index :products, :name

    change_column :products, :fob_price_currency_id, "varchar USING CAST(fob_price_currency_id AS varchar)"
    rename_column :products, :fob_price_currency_id, :fob_price_currency

    change_column :products, :fob_price_unit_id, "varchar USING CAST(fob_price_unit_id AS varchar)"
    rename_column :products, :fob_price_unit_id, :fob_price_unit

    change_column :products, :supply_ability_unit_id, "varchar USING CAST(supply_ability_unit_id AS varchar)"
    rename_column :products, :supply_ability_unit_id, :supply_ability_unit

    change_column :products, :supply_ability_frequency_id, "varchar USING CAST(supply_ability_frequency_id AS varchar)"
    rename_column :products, :supply_ability_frequency_id, :supply_ability_frequency

    change_column :products, :min_order_quantity_unit_id, "varchar USING CAST(min_order_quantity_unit_id AS varchar)"
    rename_column :products, :min_order_quantity_unit_id, :min_order_quantity_unit
  end
end
