class UserRepository < AbstractRepository
  def find_by_omniauth(auth)
    klass.where(provider: auth["provider"], uid: auth["uid"]).first
  end
end
