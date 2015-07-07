class BusinessItem::ProductPhotoCreator
  takes :product_photo_repository

  def perform(product, photo)
    photo_creator = BusinessItem::PhotoCreator.new(product_photo_repository)
    photo_creator.perform(product, photo)
  end
end
