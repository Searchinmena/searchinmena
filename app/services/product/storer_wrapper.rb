class Product::StorerWrapper
  def create_storer(product, product_params)
    Product::ProductStorer.new(product, product_params)
  end
end
