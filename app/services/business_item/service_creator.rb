class BusinessItem::ServiceCreator < BaseService
  inject :business_repository, :service_repository
  takes :params, :user

  def perform
    business = business_repository.find_by_user_id(user.id)
    return Response.new(success: false) unless business.present?

    business_item_handler(business, params).perform
  end

  private

  def business_item_handler(business, params)
    service = service_repository.find_or_new_for_business(
      business,
      params[:business_item]
    )
    records = { user: user, business_item: service }
    BusinessItem::ServiceStoringHandler.new(
      records[:business_item], params[:business_item],
      params[:attributes], params[:payment_terms], params[:photos]
    )
  end
end
