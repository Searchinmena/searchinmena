class UserResourceRepository < AbstractRepository
  def find_for_user(user, id)
    business = user.business
    return unless business

    klass.where(id: id, business_id: business.id).first
  end
end
