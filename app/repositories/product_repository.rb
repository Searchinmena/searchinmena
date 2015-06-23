class ProductRepository < AbstractRepository
  def add_category(product, category)
    product.categories << category
  end

  def find_for_user(user, id)
    business = user.business
    return unless business

    business.products.find_by_id(id)
  end
end
