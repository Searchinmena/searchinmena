class Registration::StorerFactory
  CATEGORIES = {
    buyer: Registration::BuyerStorer,
    seller: Registration::SellerStorer,
    both: Registration::SellerStorer
  }

  def from_category(category, user, user_params, business, business_params)
    category ||= :buyer
    klass = CATEGORIES[category.to_sym]
    klass.new(user, user_params, business, business_params)
  end
end
