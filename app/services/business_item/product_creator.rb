class BusinessItem::ProductCreator < BaseCreator
  inject :product_repository

  attr_accessor :product

  def initialize(product, product_params, attributes_params)
    self.product = product
    self.validator = ProductValidator.new(product_params)
    self.storing_handler = ::StoringHandler.new(
      product, product_params, product_repository, validator)
  end

  def copy_errors
    validator.copy_errors(product)
  end
end
