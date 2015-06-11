class ProductRepository < AbstractRepository
  def add_category(product, category)
    product.categories << category
  end
end
