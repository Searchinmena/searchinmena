class BusinessRepository < AbstractRepository
  def add_tag(business, tag)
    business.tags << tag
  end

  def find_by_user_id(user_id)
    klass.where(user_id: user_id).first
  end
end

