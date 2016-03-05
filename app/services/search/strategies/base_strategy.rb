class Search::Strategies::BaseStrategy
  takes :repositories

  def perform(type, query)
    results = repository.where_name_like(query[:query])
    results = search_with_business_type(results, type, query)
    results = search_with_country(results, type, query)
    results = search_with_category(results, type, query)
    results = sort_business_on_weight(results, type)
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

  def sort_business_on_weight(results, type)
    if type == 'business'
      results = sort_business(results)
    elsif type == 'service'
      results = sort_services(results)
    else
      results = sort_products(results)
    end
    results
  end

  def sort_business(results)
    filered_results = results.select { |u| u.feature == true }
    .sort { |a, b|  a.weight <=> b.weight }.reverse
    (filered_results + (results - filered_results)).uniq.flatten
  end

  def sort_services(results)
    filered_results = Service.joins(:business)
    .where("services.id IN (?) and businesses.feature = true",
    results.map(&:id))
    .order("businesses.weight DESC")
    (filered_results + (results - filered_results)).uniq.flatten
  end

  def sort_products(results)
    filered_results = Product.joins(:business)
    .where("products.id IN (?) and businesses.feature = true",
    results.map(&:id)).order("businesses.weight DESC")
    (filered_results + (results - filered_results)).uniq.flatten
  end
end