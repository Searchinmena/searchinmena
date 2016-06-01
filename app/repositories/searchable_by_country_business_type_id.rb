module SearchableByCountryBusinessTypeId
  def search_with_country_or_business(query, condition, page)
    query = '*' if query.blank? || query.nil?
    results = klass.search(query, fields: [:name, :tag_name], where: condition,
                                  misspellings: false,
                                  order: { feature: :desc, weight: :desc },
                                  page: page, per_page: 10)

    [results.records, results.total_count]
  end
end
