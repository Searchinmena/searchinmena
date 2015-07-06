class TagRepository < TranslatableRepository
  def find_with_query(query, locale)
    return all_with_translations(locale) if query.blank?

    collection = klass.joins(:translations).includes(:translations)
      .where("translations.locale": locale)
      .where("LOWER(value) LIKE LOWER(?)", "#{query}%")
    ordered(collection)
  end

  def ordered(collection)
    collection.order('LOWER(translations.value)')
  end
end
