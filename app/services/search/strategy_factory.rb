class Search::StrategyFactory
  takes :product_repository, :service_repository, :business_repository

  STRATEGIES = {
    product: Search::Strategies::ProductStrategy,
    service: Search::Strategies::ServiceStrategy,
    business: Search::Strategies::BusinessStrategy,
    all: Search::Strategies::AllStrategy
  }

  def build(type)
    type ||= :all
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
