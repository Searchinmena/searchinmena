module BusinessItemRepository
  def for_user(user)
    business = user.business
    return klass.none unless business

    klass.includes(:category, :category_translations, :photos)
      .where("business_id = ?", user.business.id)
  end

  def new_for_business(business, params)
    klass.new params.merge(business_id: business.id)
  end

  def photo_url_for(business_item, type = nil)
    photo = business_item.photos.first
    return default_image_for(type) unless photo
    photo.photo_url(type)
  end

  private

  def default_image_for(type)
    image = type ? "default-image-#{type}.png" : "default-image.png"
    ActionController::Base.helpers.asset_path(image)
  end
end
