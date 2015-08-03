class ServicesController < BusinessItemsController
  inject :service_repository

  def repository
    service_repository
  end

  def business_item_creator
    BusinessItem::ServiceCreator.new(service_params, current_user)
  end

  def business_item_presenter_factory
    ServicePresenter
  end

  def resource_name
    :service
  end

  def business_item_params
    service_specific_params = params.permit(
      [:place_of_origin, :scope_of_work, :average_completion_time,
       :average_completion_time_unit_id])
    super.merge(service_specific_params)
  end

  def service_params
    {
      business_item: business_item_params,
      photos: photos_params,
      attributes: attributes_params,
      payment_terms: payment_terms_params
    }
  end
end

