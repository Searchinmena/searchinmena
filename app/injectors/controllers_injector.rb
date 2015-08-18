class ControllersInjector
  include Dependor::AutoInject

  takes :params, :session, :request

  def product_photo_creator
    ProductPhotoCreator.new(product_photo_repository)
  end

  def user_category_service
    UserCategoryService.new(user_repository)
  end

  def messages_sender
    MessagesSender.new(MessageValidator, message_formatter)
  end
end

