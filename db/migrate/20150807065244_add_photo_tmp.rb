class AddPhotoTmp < ActiveRecord::Migration
  def change
    add_column :product_photos, :photo_tmp, :string
    add_column :service_photos, :photo_tmp, :string

    change_column :product_photos, :photo, :string, null: true
    change_column :service_photos, :photo, :string, null: true
  end
end
