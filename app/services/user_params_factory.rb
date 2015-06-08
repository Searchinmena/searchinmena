class UserParamsFactory
  def hash
    {
      user: UserPrefillParams,
      facebook: FacebookUserPrefillParams
    }
  end

  def build(attributes)
    attributes ||= {}
    user_type = attributes["provider"] || :user
    hash[user_type.to_sym].new(attributes).attributes
  end
end
