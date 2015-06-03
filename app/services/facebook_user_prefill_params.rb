class FacebookUserPrefillParams
  attr_accessor :attributes

  def initialize(facebook_attributes)
    password = Devise.friendly_token

    self.attributes = {
      first_name: facebook_attributes["info"]["first_name"],
      last_name: facebook_attributes["info"]["last_name"],
      email: facebook_attributes["info"]["email"],
      password: password,
      password_confirmation: password,
      provider: facebook_attributes["provider"],
      uid: facebook_attributes["uid"]
    }
  end
end
