class AttributePresenter
  takes :attribute

  def as_json(*)
    { name: attribute.name, value: attribute.value }
  end
end
