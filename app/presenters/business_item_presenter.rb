class BusinessItemPresenter < BasePresenter
  inject :translatable_repository

  takes :business_item, :repository, :photos_repository, :locale

  def as_json(*)
    basic_attributes.merge(
      breadcrumbs: breadcrumbs,
      attributes: attributes,
      photos: photos,
      cover_photo: cover_photo,
      payment_terms: PaymentTermsPresenter.new(business_item, locale)
    )
  end

  private

  def cover_photo
    {
      url: repository.cover_photo_url_for(business_item, photos_repository),
      bigger_thumb: repository.cover_photo_url_for(business_item,
                                            photos_repository, :bigger_thumb),
      thumb: repository.cover_photo_url_for(business_item,
                                            photos_repository, :thumb)
    }
  end

  def basic_attributes
    {
      id: business_item.id,
      business: BasicBusinessPresenter.new(business_item.business, locale),
      name: business_item.name,
      category_id: business_item.category_id,
      description: business_item.description,
      fob_price: business_item.fob_price,
      fob_price_currency_id: business_item.fob_price_currency_id,
      fob_price_currency: fob_price_currency,
      fob_price_unit_id: business_item.fob_price_unit_id,
      fob_price_unit: fob_price_unit,
      port: business_item.port,
      supply_ability_capacity: business_item.supply_ability_capacity,
      supply_ability_unit_id: business_item.supply_ability_unit_id,
      supply_ability_unit: supply_ability_unit,
      supply_ability_frequency_id: business_item.supply_ability_frequency_id,
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
    business_item.photos.map { |p| PhotoPresenter.new(p, photos_repository) }
  end

  def attributes
    attributes_collection.map { |a| AttributePresenter.new(a) }
  end
end
