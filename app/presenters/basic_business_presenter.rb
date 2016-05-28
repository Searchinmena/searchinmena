class BasicBusinessPresenter < BasePresenter
  inject :translatable_repository

  takes :business, :locale
  ITEM_LIMIT = A9n.validations[:max_product_service_limit]

  def as_json(*)
    if business.present?
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
  end

  private

  def can_add_products
    business.feature || (business.products.count < ITEM_LIMIT)
  end

  def can_add_services
    business.feature || (business.services.count < ITEM_LIMIT)
  end

  def country
    translatable_repository.translation_for(business.country, locale)
  end
end
