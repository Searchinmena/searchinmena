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
end
