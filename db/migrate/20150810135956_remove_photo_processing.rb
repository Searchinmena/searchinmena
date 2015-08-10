class RemovePhotoProcessing < ActiveRecord::Migration
  def change
    remove_column :product_photos, :photo_processing
    remove_column :service_photos, :photo_processing
  end
end
