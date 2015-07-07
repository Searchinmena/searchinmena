class BusinessPresenter
  takes :business

  def as_json(*)
    { id: business.id }
  end
end
