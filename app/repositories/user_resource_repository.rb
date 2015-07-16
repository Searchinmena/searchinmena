class UserResourceRepository < AbstractRepository
  def find_for_user(user, id)
    for_user(user).where(id: id).first
  end

  def for_user(user)
    business = user.business
    return klass.none unless business

    klass.where(business_id: business.id)
  end
end
