class CategoryRepository < AbstractRepository
  def find_by_key(key)
    klass.where(key: key).first
  end

  def update_parent(category, parent)
    category.parent = parent
    category.save
  end

  def for_parent_id(parent_id, locale)
    klass.joins(:translations).includes(:translations)
      .where(parent_id: parent_id, "translations.locale": locale).order(:id)
  end
end
