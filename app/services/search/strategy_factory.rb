class Search::StrategyFactory
  takes :product_repository, :service_repository, :business_repository

  STRATEGIES = {
    product: Search::Strategies::ProductStrategy,
    service: Search::Strategies::ServiceStrategy,
    company: Search::Strategies::BusinessStrategy
  }

  def build(type)
    klass = STRATEGIES[type.to_sym]
    klass.new(repositories)
  end

  def repositories
    {
      product: product_repository,
      service: service_repository,
      business: business_repository
    }
  end
end
