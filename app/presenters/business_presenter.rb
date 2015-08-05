class BusinessPresenter < BasePresenter
  inject :translatable_repository

  takes :business, :locale

  def as_json(*)
    {
      id: business.id,
      name: business.name,
      phone: business.phone,
      city: business.city,
      country_id: business.country_id,
      country: country,
      year_registered: business.year_registered,
      no_of_employees: business.no_of_employees,
      introduction: business.introduction,
      address_line_1: business.address_line_1,
      address_line_2: business.address_line_2,
      business_type_ids: business.business_type_ids
    }
  end

  private

  def country
    translatable_repository.translation_for(business.country, locale)
  end
end
