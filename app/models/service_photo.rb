class ServicePhoto < ActiveRecord::Base
  belongs_to :service

  mount_uploader :photo, BusinessItemPhotoUploader
end
