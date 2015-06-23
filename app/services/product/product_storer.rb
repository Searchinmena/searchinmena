class Product::ProductStorer < Product::Storer
  def initialize(product, product_params)
    product_creator = Product::ProductCreator.new(product, product_params)
    self.handlers = [product_creator]
  end
end

