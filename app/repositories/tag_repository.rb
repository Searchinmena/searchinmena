class TagRepository < TranslatableRepository
  def find_with_query(query, locale)
    return all_with_translations(locale) if query.blank?

    collection = klass.joins(:translations).includes(:translations)
      .where("translations.locale": locale)
      .where("LOWER(value) LIKE LOWER(?)", "#{query}%")
    ordered(collection)
  end

  def for_business_with_translations(business_id, locale)
    all_with_translations(locale).joins(:businesses)
      .where('businesses.id': business_id)
  end

  def ordered(collection)
    collection.order('LOWER(translations.value)')
  end
end
