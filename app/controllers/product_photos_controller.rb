class ProductPhotosController < PhotosController
  inject :product_repository, :product_photo_repository

  def repository
    product_repository
  end

  def photo_creator
    BusinessItem::ProductPhotoCreator.new(product_photo_repository)
  end
end
