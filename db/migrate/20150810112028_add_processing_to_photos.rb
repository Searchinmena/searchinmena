class AddProcessingToPhotos < ActiveRecord::Migration
  def change
    add_column :product_photos, :photo_processing, :boolean, null: false, default: false
    add_column :service_photos, :photo_processing, :boolean, null: false, default: false
  end
end
