class Registration::Storer
  attr_accessor :handlers

  CATEGORIES = {
    buyer: Registration::BuyerStorer,
    seller: Registration::SellerStorer,
    both: Registration::SellerStorer
  }

  def self.from_category(category, user, user_params, business, business_params)
    category ||= :buyer
    klass = CATEGORIES[category.to_sym]
    klass.new(user, user_params, business, business_params)
  end

  def valid?
    handlers.map(&:valid?).all?
  end

  def store
    handlers.map(&:perform).all?(&:successful?)
  end

  def copy_errors
    handlers.each(&:copy_errors)
    false
  end
end
