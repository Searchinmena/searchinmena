class BusinessItem::AttributesCreator
  takes :repository, :params, :business_item

  def perform
    responses = params.map do |attribute_params|
      attribute_params = attributes_with_business_item(attribute_params,
                                                       business_item)
      attribute = repository.new(attribute_params)
      validator = AttributeValidator.new(attribute_params)
      storing_handler = StoringHandler.new(attribute, attribute_params,
                                           repository, validator)
      storing_handler.perform
    end
    Response.new(success: responses.all?(&:successful?), object: business_item)
  end

  def attributes_with_business_item(attribute_params, business_item)
    repository.attributes_with_business_item(
      { name: attribute_params[:name], value: attribute_params[:value] },
      business_item
    )
  end
end
