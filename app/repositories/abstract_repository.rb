class AbstractRepository
  delegate :new, :find_by_id, :all, :first, :last, to: :klass

  def save(object)
    object.save
  end

  def update(object, attributes)
    object.update(attributes)
  end

  def destroy(object)
    object.destroy
  end

  private

  def klass
    self.class.name.sub("Repository", "").constantize
  end
end
