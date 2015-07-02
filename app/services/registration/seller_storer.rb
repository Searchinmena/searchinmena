class Registration::SellerStorer < Registration::Storer
  def initialize(records, registration_params)
    user = records[:user]
    user_creator = Registration::UserCreator.new(user,
                                                 registration_params[:user])
    business_creator = Registration::BusinessCreator.new(records[:business],
                                        registration_params[:business],
                                        registration_params[:tags],
                                        registration_params[:business_types],
                                        user)

    self.handlers = [user_creator, business_creator]
  end
end
