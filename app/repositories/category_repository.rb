class CategoryRepository < AbstractRepository
  def find_by_key(key)
    klass.where(key: key).first
  end

  def update_parent(category, parent)
    category.parent = parent
    category.save
  end
end
