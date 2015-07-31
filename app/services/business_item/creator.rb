class BusinessItem::Creator < BaseService
  inject :business_repository, :product_repository
  takes :params, :user

  def perform
    business = business_repository.find_by_user_id(user.id)
    return Response.new(success: false) unless business.present?

    product = product_repository.new_for_business(business, params[:business_item])

    records = {user: user, product: product}

    product_creator = BusinessItem::ProductStoringHandler.new(records[:product],
                                                               params[:business_item],
                                                               params[:attributes],
                                                               params[:photos]).perform
  end
end
