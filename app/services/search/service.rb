class Search::Service
  takes :search_strategy_factory

  def perform(search_params)
    type = search_params[:type]
    search_strategy = search_strategy_factory.build(type)

    query = search_params[:query]
    search_strategy.perform(query)
  end
end
