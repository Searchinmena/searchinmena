class UserPresenter
  takes :user

  def as_json(*)
    {
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      provider: user.provider,
      uid: user.uid
    }
  end
end
