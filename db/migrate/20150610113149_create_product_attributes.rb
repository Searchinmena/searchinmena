class CreateProductAttributes < ActiveRecord::Migration
  def change
    create_table :product_attributes do |t|
      t.string :name, null: false
      t.string :value, null: false
      t.integer :product_id

      t.timestamps null: false
    end

      add_index :product_attributes, :product_id
  end
end
