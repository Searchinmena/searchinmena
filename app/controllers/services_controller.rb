class ServicesController < BusinessItemsController
  inject :service_repository

  def repository
    service_repository
  end

  def business_item_creator
    BusinessItem::ServiceCreator.new(business_item_data, current_user)
  end

  def business_item_presenter_factory
    ServicePresenter
  end

  def resource_name
    :service
  end

  def business_item_params
    service_specific_params = business_item_parsed_params.permit(
      [:place_of_origin, :scope_of_work, :average_completion_time,
       :average_completion_time_unit_id])
    super.merge(service_specific_params)
  end
end

