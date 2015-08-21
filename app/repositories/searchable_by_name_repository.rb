module SearchableByNameRepository
  def where_name_like(query)
    klass.where("name ILIKE ?", "%#{query}%")
  end
end
