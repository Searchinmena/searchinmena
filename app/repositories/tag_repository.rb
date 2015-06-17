class TagRepository < AbstractRepository
  def find_with_query(query)
    return klass.all if query.blank?

    klass.where("LOWER(name) LIKE LOWER(?) ", "#{query}%")
  end
end
