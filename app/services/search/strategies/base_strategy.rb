class Search::Strategies::BaseStrategy
  takes :repositories

  def perform(type, query)
    results = repository.where_name_like(type, query[:query])
    results = search_with_business_type(results, type, query)
    results = search_with_country(results, type, query)
    results = search_with_category(results, type, query)

    Search::Response.new(success: true, results: results)
  end

  private

  def search_with_business_type(results, type, query)
    if query[:business_type].present? && type == 'business'
      repository.where_business_type(results, query[:business_type])
    else
      results
    end
  end

  def search_with_country(results, type, query)
    if query[:country].present? && type == 'business'
      repository.where_country(results, query[:country])
    else
      results
    end
  end

  def search_with_category(results, type, query)
    if query[:category].present? && (type == 'product' || type == 'service')
      repository.where_category_id(results, query[:category])
    else
      results
    end
  end
end