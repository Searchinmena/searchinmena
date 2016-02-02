class Search::Strategies::BaseStrategy
  takes :repositories

  def perform(type, query)
    results = repository.where_name_like(query[:query])
    if query[:business_type].present? && type == 'business'
      results = repository.where_business_type(results, query[:business_type])
    end
    if query[:category].present? && (type == 'product' || type == 'service')
      results = repository.where_category_id(results, query[:category])
    end

    Search::Response.new(success: true, results: results)
  end
end
