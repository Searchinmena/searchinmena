class AbstractRepository
  delegate :new, :find_by_id, :all, :first, :last, :count, to: :klass

  def save(object)
    object.save
  end

  def update(object, attributes)
    object.update(attributes)
  end

  def destroy(object)
    object.destroy
  end

  def find_or_create(attributes)
    klass.find_or_create_by(attributes)
  end

  def find_or_build(attributes)
    klass.find_or_initialize_by(attributes)
  end

  private

  def klass
    self.class.name.sub("Repository", "").constantize
  end
end
