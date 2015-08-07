class ProductPhoto < ActiveRecord::Base
  belongs_to :product

  mount_uploader :photo, BusinessItemPhotoUploader
  store_in_background :photo
end
