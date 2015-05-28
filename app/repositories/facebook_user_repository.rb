class FacebookUserRepository
  takes :user_repository

  def new(facebook_attributes)
    attributes = {
      first_name: facebook_attributes["info"]["first_name"],
      last_name: facebook_attributes["info"]["last_name"],
      email: facebook_attributes["info"]["email"],
      password: Devise.friendly_token[0, 20]
    }
    user_repository.new(attributes)
  end
end
