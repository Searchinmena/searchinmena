class Search::ResultPresenterFactory
  takes :product_repository, :product_photo_repository,
    :service_repository, :service_photo_repository,
    :business_repository

  Item = Struct.new(:klass, :args)

  def items
    {
      product: Item.new(ProductResultPresenter,
                        [product_repository,
                         product_photo_repository]),
      service: Item.new(ServiceResultPresenter,
                        [service_repository,
                         service_photo_repository]),
      business: Item.new(BusinessResultPresenter, [])
    }
  end

  def build(result, locale)
    key = key(result)
    item = items[key]
    args = item.args + [locale]
    item.klass.new(result, key, *args)
  end

  def key(result)
    result.class.to_s.underscore.to_sym
  end
end
