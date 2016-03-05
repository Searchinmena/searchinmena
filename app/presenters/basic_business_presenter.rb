class BasicBusinessPresenter < BasePresenter
  inject :translatable_repository

  takes :business, :locale

  def as_json(*)
    {
      id: business.id,
      name: business.name,
      city: business.city,
      country: country,
      feature: business.feature,
      weight: business.weight,
      can_add_products: can_add_products,
      can_add_services: can_add_services
    }
  end

  private

  def can_add_products
    business.feature || (business.products.count < business.limit)
  end

  def can_add_services
    business.feature || (business.services.count < business.limit)
  end

  def country
    translatable_repository.translation_for(business.country, locale)
  end
end
