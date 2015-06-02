class Registration::BuyerStorer < Registration::Storer
  def initialize(user, user_params, _, _)
    self.handlers = [
      Registration::UserStoringHandler.new(user, user_params)
    ]
  end
end
