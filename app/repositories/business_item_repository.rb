module BusinessItemRepository
  def for_user(user)
    business = user.business
    return klass.none unless business

    klass.includes(:category, :category_translations, :photos)
      .where("business_id = ?", user.business.id)
  end

  def photo_url_for(product, type = nil)
    photo = product.photos.first
    return unless photo

    photo.photo_url(type)
  end
end
