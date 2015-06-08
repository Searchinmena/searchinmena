class UserRepository < AbstractRepository
  def find_by_omniauth(auth)
    klass.where(provider: auth["provider"], uid: auth["uid"]).first
  end

  def setup(user_params)
    if user_params["provider"].present?
      password = generate_password
      user_params.merge!("password" => password,
                         "password_confirmation" => password)
    end

    new(user_params)
  end

  private

  def generate_password
    Devise.friendly_token
  end
end
