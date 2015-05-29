class UserFactory
  takes :user_repository, :facebook_user_repository

  def hash
    {
      user: user_repository,
      facebook: facebook_user_repository
    }
  end

  def build(attributes)
    attributes ||= {}
    user_type = user_type(attributes["provider"])
    hash[user_type].new(attributes)
  end

  private

  def user_type(provider)
    if provider == "facebook"
      :facebook
    else
      :user
    end
  end
end
