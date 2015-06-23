class ProductPresenter
  takes :product

  def as_json(*)
    { id: product.id }
  end
end
