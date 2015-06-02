class Registration::SellerStorer < Registration::Storer
  def initialize(user, user_params, business, business_params)
    self.handlers = [
      Registration::UserStoringHandler.new(user, user_params),
      Registration::BusinessStoringHandler.new(business, business_params, user)
    ]
  end
end
