class ServiceHtmlController < BusinessItemsController
  inject :service_repository, :service_photo_repository

  def show
    business_item = repository.find_by_id(params[:id])
    return head :not_found unless business_item
    @service_presenter = business_item_presenter_factory.new(
      business_item, repository, photos_repository, locale).as_json
    if !browser.bot?
      redirect_to "/service/#{params[:id]}"
    end
  end

  def repository
    service_repository
  end

  def photos_repository
    service_photo_repository
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
