class SimilarBusinessItemsPresenter
  takes :business_item

  def as_json(*)
    {
      id: business_item.id,
      name: business_item.name,
      photo: business_item_photo
    }
  end

  private

  def business_item_photo
    business_item.photos.first.present? ? business_item.photos.first.photo : ''
  end
end
