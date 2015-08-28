class BusinessPhoto < ActiveRecord::Base
  belongs_to :business

  mount_uploader :photo, BusinessPhotoUploader
  store_in_background :photo
end
