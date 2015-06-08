class FacebookUserPrefillParams
  attr_accessor :attributes

  def initialize(facebook_attributes)
    self.attributes = {
      first_name: facebook_attributes["info"]["first_name"],
      last_name: facebook_attributes["info"]["last_name"],
      email: facebook_attributes["info"]["email"],
      provider: facebook_attributes["provider"],
      uid: facebook_attributes["uid"]
    }
  end
end
