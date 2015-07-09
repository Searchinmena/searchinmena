class CreateServicePhotos < ActiveRecord::Migration
  def change
    create_table :service_photos do |t|
      t.string :photo, null: false
      t.integer :service_id, null: false, index: true

      t.timestamps null: false
    end
  end
end
