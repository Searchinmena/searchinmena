class Registration::StorerFactory
  CATEGORIES = {
    buyer: Registration::BuyerStorer,
    seller: Registration::SellerStorer,
    both: Registration::SellerStorer
  }

  def from_category(category, records, registration_params)
    category = category.presence || :buyer
    klass = CATEGORIES[category.to_sym]
    klass.new(records, registration_params)
  end
end
