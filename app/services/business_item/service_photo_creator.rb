class BusinessItem::ServicePhotoCreator
  takes :service_photo_repository

  def perform(service, photo)
    photo_creator = BusinessItem::PhotoCreator.new(service_photo_repository)
    photo_creator.perform(service, photo)
  end
end
