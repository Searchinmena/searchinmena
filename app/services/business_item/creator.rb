class BusinessItem::Creator < BaseService
  inject :business_repository

  takes :item_repository, :validator_factory, :attributes_creator_factory,
        :payment_terms_creator_factory, :params, :user

  def perform
    business = business_repository.find_by_user_id(user.id)
    return Response.new(success: false) unless business.present?

    response = save_business_item(business)
    return response unless response.successful?

    business_item = response.object
    save_attributes_for(business_item)

    save_payment_terms_for(business_item)
  end

  def save_business_item(business)
    business_item_params = params[:business_item].merge(business: business)
    business_item = item_repository.new(business_item_params)
    validator = validator_factory.new(business_item_params)
    storing_handler = StoringHandler.new(business_item, business_item_params,
                                         item_repository, validator)
    storing_handler.perform
  end

  def save_attributes_for(business_item)
    attributes_creator = attributes_creator_factory.new(
      params[:attributes],
      business_item
    )
    attributes_creator.perform
  end

  def save_payment_terms_for(business_item)
    payment_terms_creator = payment_terms_creator_factory.new(
      params[:payment_terms],
      business_item
    )
    payment_terms_creator.perform
  end
end

