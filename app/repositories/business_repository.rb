class BusinessRepository < AbstractRepository
  def update_tags(business, tags)
    business.update(tags: tags)
  end

  def find_by_user_id(user_id)
    klass.where(user_id: user_id).first
  end
end
