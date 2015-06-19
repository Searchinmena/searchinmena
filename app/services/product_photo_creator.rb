class ProductPhotoCreator < BaseService
  inject :product_photo_repository

  def perform(product, photo)
    record = product_photo_repository.new
    product_photo_params = { product: product, photo: photo }
    validator = ProductPhotoValidator.new(product_photo_params)
    handler = StoringHandler.new(record, product_photo_params,
                                 product_photo_repository, validator)
    handler.perform
  end
end
