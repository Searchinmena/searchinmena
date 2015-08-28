class BusinessPresenter < BasicBusinessPresenter
  def as_json(*)
    super.merge(
      logo: [business.logo_url].compact,
      default_logo: default_logo_url,
      phone: business.phone,
      country_id: business.country_id,
      year_registered: business.year_registered,
      no_of_employees: business.no_of_employees,
      introduction: business.introduction,
      address_line_1: business.address_line_1,
      address_line_2: business.address_line_2,
      business_type_ids: business.business_type_ids
    )
  end

  private

  def default_logo_url
    ActionController::Base.helpers.asset_path("default-image.png")
  end
end
