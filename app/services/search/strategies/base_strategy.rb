class Search::Strategies::BaseStrategy
  takes :repositories, :search_query_validator_factory

  def perform(query)
    search_query_validator = search_query_validator_factory.new(query)
    if search_query_validator.valid?
      results = repository.where_name_like(query)
      Search::Response.new(success: true,
                           results: results)
    else
      Search::Response.new(success: false,
                           errors: search_query_validator.errors)
    end
  end
end
