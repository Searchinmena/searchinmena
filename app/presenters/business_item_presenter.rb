class BusinessItemPresenter < BasePresenter
  inject :payment_term_repository, :translatable_repository

  takes :business_item, :locale

  def as_json(*)
    basic_attributes.merge(
      breadcrumbs: breadcrumbs,
      attributes: attributes,
      photos: photos,
      cover_photo: cover_photo,
      payment_terms: payment_terms
    )
  end

  private

  def basic_attributes
    {
      id: business_item.id,
      name: business_item.name,
      description: business_item.description,
      fob_price: business_item.fob_price,
      fob_price_currency: fob_price_currency,
      fob_price_unit: fob_price_unit,
      port: business_item.port,
      supply_ability_capacity: business_item.supply_ability_capacity,
      supply_ability_unit: supply_ability_unit,
      supply_ability_frequency: supply_ability_frequency,
      packaging_details: business_item.packaging_details
    }
  end

  def fob_price_currency
    translatable_repository.translation_for(
      business_item.fob_price_currency, locale)
  end

  def fob_price_unit
    translatable_repository.translation_for(
      business_item.fob_price_unit, locale)
  end

  def supply_ability_unit
    translatable_repository.translation_for(
      business_item.supply_ability_unit, locale)
  end

  def supply_ability_frequency
    translatable_repository.translation_for(
      business_item.supply_ability_frequency, locale)
  end

  def breadcrumbs
    BusinessItemCategoryPresenter.new(business_item.category, locale)
  end

  def photos
    business_item.photos.map { |p| PhotoPresenter.new(p) }
  end

  def cover_photo
    business_item.photos.first.photo_url if business_item.photos.present?
  end

  def attributes
    attributes_collection.map { |a| AttributePresenter.new(a) }
  end

  def payment_terms
    payment_term_repository.for_business_item(business_item, locale).map do |pt|
      PaymentTermPresenter.new(pt)
    end
  end
end
