module SearchableByCategory
  def where_category_id(results, category)
    categories = Category.where("parent_id = ?", category).pluck('id')
    categories.push(category)
    results.where("category_id IN (?)", categories)
  end
end
