class UserPresenter
  takes :user

  def as_json(*)
    {
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      provider: user.provider,
      uid: user.uid,
      can_see_business_items: user.can_see_business_items?,
      confirmed_at: user.confirmed_at,
      business_id: user.businesses.first.try(:id)
    }
  end
end
