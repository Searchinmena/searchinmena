class ServicePhoto < ActiveRecord::Base
  belongs_to :service

  mount_uploader :photo, BusinessItemPhotoUploader
  process_in_background :photo
  store_in_background :photo
end
