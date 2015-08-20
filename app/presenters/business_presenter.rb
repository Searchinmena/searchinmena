class BusinessPresenter < BasicBusinessPresenter
  def as_json(*)
    super.merge(
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
end
