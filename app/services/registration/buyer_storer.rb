class Registration::BuyerStorer < Registration::Storer
  def initialize(records, registration_params)
    self.handlers = [
      Registration::UserCreator.new(records[:user], registration_params[:user])
    ]
  end
end
