class ProductStoringHandler < BaseService
  inject :product_repository

  attr_accessor :storing_handler

  def initialize(product, product_params, validator)
    self.storing_handler = StoringHandler.new(product, product_params,
                                              product_repository, validator)
  end

  def perform
    success = [storing_handler].map(&:perform).all?
    Response.new(success: success)
  end
end
