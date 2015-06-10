class CreateProductPhotos < ActiveRecord::Migration
  def change
    create_table :product_photos do |t|
      t.string :photo, null: false
      t.integer :product_id

      t.timestamps null: false
    end
      add_index :product_photos, :product_id
  end
end
