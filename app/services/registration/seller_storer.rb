class Registration::SellerStorer < Registration::Storer
  def initialize(records, registration_params)
    user = records[:user]
    user_creator = Registration::UserCreator.new(user,
                                                 registration_params[:user])
    business_saver = Business::Saver.new(records[:business],
                                         registration_params[:business],
                                         registration_params[:tags],
                                         registration_params[:locale],
                                         user)

    self.handlers = [user_creator, business_saver]
  end
end
