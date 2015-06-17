class TranslatableRepository < AbstractRepository
  def all_with_translations(locale)
    klass.joins(:translations).includes(:translations)
      .where("translations.locale": locale)
  end
end
