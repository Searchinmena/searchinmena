class Product::ProductAttributeCreator < BaseService
  inject :product_attribute_repository

  takes :params, :product

  def perform
    params.each do |attribute_params|
      attribute_params = attribute_params.merge(product: product)
      product_attribute = product_attribute_repository.new(attribute_params)
      validator = ProductAttributeValidator.new(attribute_params)
      storing_handler = StoringHandler.new(product_attribute, attribute_params,
                                           product_attribute_repository,
                                           validator)
      storing_handler.perform
    end
  end
end
