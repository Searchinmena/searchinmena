class BusinessCreator
  takes :business_repository

  def perform(business_params, user)
    business = business_repository.new(business_params)
    validator = BusinessValidator.new(business_params)
    handler = StoringHandler.new(business, business_params,
                                 business_repository, validator)
    response = handler.perform

    if response.successful?
      business = response.object
      user.business = business
    end

    response
  end
end
