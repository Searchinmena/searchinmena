class Product::Response < ::Response
  attr_accessor :product

  def initialize(success: true, product: nil)
    self.success = success
    self.product = product
  end
end
