class ServicesController < BusinessItemsController
  inject :service_repository

  def repository
    service_repository
  end

  def business_item_creator
    BusinessItem::ServiceCreator.new(new_business_item_params, current_user)
  end

  def business_item_params
    service_specific_params = params[:business_item].permit(
      [:place_of_origin, :scope_of_work, :average_completion_time,
       :average_completion_time_unit_id])
    super.merge(service_specific_params)
  end
end

