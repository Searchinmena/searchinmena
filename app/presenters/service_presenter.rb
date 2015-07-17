class ServicePresenter < BusinessItemPresenter
  def as_json(*)
    super.merge(
      place_of_origin: business_item.place_of_origin,
      scope_of_work: business_item.scope_of_work,
      average_completion_time: business_item.average_completion_time,
      average_completion_time_unit: average_completion_time_unit
    )
  end

  def average_completion_time_unit
    translatable_repository.translation_for(
      business_item.average_completion_time_unit, locale)
  end

  def attributes_collection
    business_item.service_attributes
  end
end

