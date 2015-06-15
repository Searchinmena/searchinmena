class Product::ProductCreator < Product::BaseCreator
  attr_accessor :Product

  def initialize(product, product_params)
    self.product = product
    self.validator = ProductValidator.new(product_params)
    self.storing_handler = ProductStoringHandler.new(
      product, product_params, validator)
  end

  def copy_errors
    validator.copy_errors(product)
  end
end
