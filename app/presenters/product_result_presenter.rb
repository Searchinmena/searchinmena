class ProductResultPresenter < ProductPresenter
  takes :business_item, :key, :repository, :photos_repository, :locale

  def as_json(*)
    super.merge(key: key)
  end
end
