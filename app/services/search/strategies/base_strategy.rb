class Search::Strategies::BaseStrategy
  takes :repositories

  def perform(query)
    results = repository.where_name_like(query)
    Search::Response.new(success: true, results: results)
  end
end
