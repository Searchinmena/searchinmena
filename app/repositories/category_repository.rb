class CategoryRepository < TranslatableRepository
  def update_parent(category, parent)
    category.parent = parent
    category.save
  end

  def for_parent_id(parent_id, locale)
    with_translations(locale).where(parent_id: parent_id).order(:id)
  end

  def translation_repository
    CategoryTranslationRepository.new
  end

  def translations_table
    "category_translations"
  end

  def foreign_key
    :category_id
  end

  def hierarchy_for(category)
    hierarchy = []
    while category
      hierarchy.unshift(category)
      category = category.parent
    end
    hierarchy
  end

  def translation_for(category)
    category.translations.first.value
  end
end
