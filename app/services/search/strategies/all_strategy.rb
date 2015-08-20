class Search::Strategies::AllStrategy
  takes :repositories

  def perform(query)
    results = repositories.values.map do |repository|
      repository.where_name_like(query)
    end.flatten

    Search::Response.new(success: true, results: results)
  end
end
