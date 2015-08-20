class Search::ResultPresenterFactory
  takes :product_repository, :product_photo_repository,
    :service_repository, :service_photo_repository

  RepositoryItem = Struct.new(:klass, :repository, :photo_repository)

  def repositories
    {
      product: RepositoryItem.new(ProductPresenter,
                                  product_repository,
                                  product_photo_repository),
      service: RepositoryItem.new(ServicePresenter,
                                  service_repository,
                                  service_photo_repository)
    }
  end

  def build(result, type, locale)
    item = repositories[type.to_sym]
    item.klass.new(result, item.repository, item.photo_repository, locale)
  end
end
