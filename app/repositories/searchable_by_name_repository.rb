module SearchableByNameRepository
  LIMIT = A9n.items_in_autocomplete

  def where_name_like(_type, keywords, page = nil)
    keywords = '*' if keywords.blank? || keywords.nil?
    page = 1 if page.nil?
    offset = (page.to_i - 1) * 10
    klass.search(keywords, fields: [:name, :category_name],
                           limit: 10, misspellings: false,
                           offset: offset).records

    # klass.search(keywords, limit: 10, operator: "or", offset: offset).records
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
