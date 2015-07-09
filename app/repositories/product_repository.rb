class ProductRepository < UserResourceRepository
  def photo_url_for(product, type = nil)
    photo = product.photos.first
    return unless photo

    photo.photo_url(type)
  end
end
