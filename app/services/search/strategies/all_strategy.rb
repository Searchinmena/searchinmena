class Search::Strategies::AllStrategy
  takes :repositories

  def perform(_type, query)
    results = repositories.values.map do |repository|
      repository.where_name_like(query[:query])
    end.flatten
    results = sort_by_weight(results)
    Search::Response.new(success: true, results: results)
  end

  private

  def sort_by_weight(results)
    ordered = []
    results.select { |u| u.class.name == "Business" && u.feature == true }
    .sort { |a, b|  a.weight <=> b.weight }.reverse_each do |business|
      ordered << business
      ordered << sort_by_created_at(results, business)
    end
    flatten_result(ordered, results)
  end

  def sort_by_created_at(results, business)
    res = results
    .select { |r| r.business_id == business.id if r.class.name != "Business" }
    .compact
    res.sort { |a, b|  a.created_at <=> b.created_at }
  end

  def flatten_result(ordered, results)
    (ordered.flatten + (results - ordered)
      .sort { |a, b|  a.created_at <=> b.created_at }).uniq.flatten
  end
end
