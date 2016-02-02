module SearchableByNameRepository
  def where_name_like(keywords)
    klass.where("name ILIKE ?", "%#{keywords}%")
  end
end
