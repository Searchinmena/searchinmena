class BusinessTypeRepository < TranslatableRepository
  def for_business_with_translations(business_id, locale)
    all_with_translations(locale).joins(:businesses)
      .where('businesses.id': business_id)
  end
end
