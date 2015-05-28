class TagRepository < AbstractRepository
  def find_or_create(attributes)
    klass.find_or_create_by(attributes)
  end
end
