class ServicePhotosController < PhotosController
  inject :service_repository, :service_photo_repository

  def repository
    service_repository
  end

  def photo_creator
    BusinessItem::ServicePhotoCreator.new(service_photo_repository)
  end
end
