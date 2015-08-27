module BusinessItemRepository
  def for_user(user)
    business = user.business
    return klass.none unless business

    klass.includes(:category, :category_translations, :photos)
      .where("business_id = ?", user.business.id)
  end

  def new_for_business(business, params)
    klass.new(params.merge(business_id: business.id))
  end

  def find_or_new_for_business(business, params)
    business_item = klass.find_by(id: params[:id], business: business)
    business_item || new_for_business(business, params)
  end

  def cover_photo_url_for(business_item, photos_repository, type = nil)
    photo = business_item.photos.first
    photos_repository.photo_url(photo, type)
  end
end
