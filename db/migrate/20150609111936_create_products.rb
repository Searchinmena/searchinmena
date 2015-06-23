class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :name, null: false
      t.string  :model_number
      t.string  :brand_name
      t.string  :description
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
