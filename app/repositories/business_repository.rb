class BusinessRepository < AbstractRepository
  include SearchableByNameRepository

  def assign_tags(business, tags)
    business.assign_attributes(tags: tags)
  end

  def find_by_user_id(user_id)
    klass.where(user_id: user_id).first
  end
end
