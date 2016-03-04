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
      weight: business.weight
    }
  end

  private

  def country
    translatable_repository.translation_for(business.country, locale)
  end
end
