module SearchableByNameRepository
  LIMIT = A9n.items_in_autocomplete

  def where_name_like(_type, keywords, page = nil)
    keywords = '*' if keywords.blank? || keywords.nil?
    page = 1 if page.nil?
    results = klass.search(keywords, fields: [:categries_name, :name],
                                     misspellings: false,
                                     order: { feature: :desc, weight: :desc },
                                     page: page, per_page: 10)
    [results.records, results.total_count]
  end

  # TODO: Create single method for search by just changing class name
  def where_search_like(type, keywords)
    keywords = '*' if keywords.blank?
    categories = case type
                 when :business
                   Tag.search(keywords, limit: LIMIT,
                                        fields: [{ name: :text_start }],
                                        misspellings: false, load: false)
                 when :product
                   ProductCategory.search(keywords, limit: LIMIT, fields:
                                                 [{ name: :text_start }],
                                                    misspellings: false,
                                                    load: false)
                 when :service
                   ServiceCategory.search(keywords, limit: LIMIT, fields:
                                                 [{ name: :text_start }],
                                                    misspellings: false,
                                                    load: false)
                 else
                   []
                 end
    results = klass.search(keywords, limit: LIMIT,
                                     fields: [{ name: :text_start }],
                                     misspellings: false, load: false)
    [categories, results]
  end
end
