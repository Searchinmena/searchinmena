class BusinessResultPresenter < BusinessPresenter
  takes :business, :key, :locale

  def as_json(*)
    super.merge(key: key)
  end
end
