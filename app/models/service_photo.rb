class ServicePhoto < ActiveRecord::Base
  belongs_to :service

  mount_uploader :photo, BusinessItemPhotoUploader
  store_in_background :photo
end
