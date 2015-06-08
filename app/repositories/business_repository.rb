class BusinessRepository < AbstractRepository
  def add_tag(business, tag)
    business.tags << tag
  end
end

