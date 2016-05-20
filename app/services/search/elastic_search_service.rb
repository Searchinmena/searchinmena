class Search::ElasticSearchService
  takes :search_strategy_factory

  def perform(type, query)
    search_strategy = search_strategy_factory.build(type)
    search_strategy.autocomplete(type, query)
  end
end
