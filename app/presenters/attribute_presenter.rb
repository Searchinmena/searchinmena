class AttributePresenter
  takes :attribute

  def as_json(*)
    { id: attribute.id, name: attribute.name, value: attribute.value }
  end
end
