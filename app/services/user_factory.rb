class UserFactory
  takes :user_repository, :facebook_user_repository

  def hash
    {
      user: user_repository,
      facebook: facebook_user_repository
    }
  end

  def build(user_type, attributes)
    attributes ||= {}
    user_type ||= :user
    hash[user_type.to_sym].new(attributes)
  end
end
