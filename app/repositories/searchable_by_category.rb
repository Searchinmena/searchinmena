module SearchableByCategory
  def where_category_id(results, category)
    results.where("category_id = ?", category)
  end
end
