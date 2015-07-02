class TranslatableRepository < AbstractRepository
  def all_with_translations(locale)
    ordered(with_translations(locale))
  end

  def with_translations(locale)
    klass.joins(:translations).includes(:translations)
      .where("#{translations_table}.locale": locale)
  end

  def ordered(collection)
    collection.order(:id)
  end

  def find_or_create_by_translation(value, locale)
    object = find_by_translation(value, locale)
    return object if object.present?

    create_with_translation(value, locale)
  end

  def find_by_translation(value, locale)
    all_with_translations(locale)
      .where("#{translations_table}.value": value,
             "#{translations_table}.locale": locale).first
  end

  def create_with_translation(value, locale)
    object = klass.create
    create_translation(object, value, locale)
    object
  end

  def create_translation(object, value, locale)
    translation = translation_repository.new(:value => value,
                                             foreign_key => object.id,
                                             :locale => locale)
    translation.save
  end

  def translation_repository
    TranslationRepository.new
  end

  def translations_table
    "translations"
  end

  def foreign_key
    :translatable_id
  end
end
