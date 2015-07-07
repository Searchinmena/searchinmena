class BusinessItemPresenter
  takes :business_item

  def as_json(*)
    { id: business_item.id }
  end
end
