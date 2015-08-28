class CreateBusinessPhotos < ActiveRecord::Migration
  def change
    create_table :business_photos do |t|
      t.string :photo, null: false
      t.integer :business_id

      t.timestamps null: false
    end

    add_index :business_photos, :business_id
  end
end
