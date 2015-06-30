class ProductRepository < AbstractRepository
  def find_for_user(user, id)
    business = user.business
    return unless business

    business.products.find_by_id(id)
  end
end
