class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :name, null: false
      t.string :value, null: false
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
