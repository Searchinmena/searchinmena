class TagRepository < AbstractRepository
  def find_or_create(attributes)
    klass.find_or_create_by(attributes)
  end

  def find_with_query(query)
    return klass.all if query.blank?

    klass.where("name LIKE ?", "#{query}%")
  end
end
