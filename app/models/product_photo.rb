class ProductPhoto < ActiveRecord::Base
  belongs_to :product

  mount_uploader :photo, BusinessItemPhotoUploader
  process_in_background :photo
  store_in_background :photo
end
