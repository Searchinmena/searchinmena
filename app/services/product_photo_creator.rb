class ProductPhotoCreator < BaseService
  takes :product_photo_repository

  def perform(product, photo)
    product_photo = product_photo_repository.new
    product_photo_params = { product: product, photo: photo }
    validator = ProductPhotoValidator.new(product_photo_params)
    handler = StoringHandler.new(product_photo, product_photo_params,
                                 product_photo_repository, validator)
    handler.perform
  end
end
