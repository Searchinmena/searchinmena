class ControllersInjector
  include Dependor::AutoInject

  takes :params, :session, :request

  def product_photo_creator
    ProductPhotoCreator.new(product_photo_repository)
  end
end

