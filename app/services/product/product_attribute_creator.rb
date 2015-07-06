class Product::ProductAttributeCreator < BaseService
  inject :product_attribute_repository

  takes :params, :product

  def perform
    responses = params.map do |attribute_params|
      attribute_params = attribute_params.merge(product: product)
      product_attribute = product_attribute_repository.new(attribute_params)
      validator = ProductAttributeValidator.new(attribute_params)
      storing_handler = StoringHandler.new(product_attribute, attribute_params,
                                           product_attribute_repository,
                                           validator)
      storing_handler.perform
    end
    Response.new(success: responses.all?(&:successful?), object: product)
  end
end
