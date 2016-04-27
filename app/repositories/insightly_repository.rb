class InsightlyRepository < AbstractRepository
  def find_by_name(name)
    klass.where(name: name).first
  end

  def find_user_insightly(user, type)
    user.insightlies.where(insightly_type: type).first
  end
end
