class AddPhotoTmpToBusinessPhoto < ActiveRecord::Migration
  def change
    add_column :business_photos, :photo_tmp, :string
    change_column :business_photos, :photo, :string, null: true
  end
end
