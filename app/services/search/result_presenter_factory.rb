class Search::ResultPresenterFactory
  takes :product_repository, :product_photo_repository,
    :service_repository, :service_photo_repository,
    :business_repository

  Item = Struct.new(:klass, :args)

  def items
    {
      product: Item.new(ProductPresenter,
                        [product_repository,
                         product_photo_repository]),
      service: Item.new(ServicePresenter,
                        [service_repository,
                         service_photo_repository]),
      business: Item.new(BusinessPresenter, [])
    }
  end

  def build(result, type, locale)
    item = items[type.to_sym]
    args = item.args + [locale]
    item.klass.new(result, *args)
  end
end
