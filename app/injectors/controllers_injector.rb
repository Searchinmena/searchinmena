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
    MessagesSender.new(MessageValidator)
  end

  def search_service
    Search::Service.new(search_strategy_factory)
  end

  def search_strategy_factory
    Search::StrategyFactory.new(product_repository,
                                service_repository,
                                business_repository)
  end

  def result_presenter_factory
    Search::ResultPresenterFactory.new(product_repository,
                                      product_photo_repository,
                                      service_repository,
                                      service_photo_repository)
  end
end

