class BusinessItemWithCategoryPresenter < BasePresenter
  takes :business_item, :repository, :photos_repository, :locale

  def as_json(*)
    {
      id: business_item.id,
      name: business_item.name,
      breadcrumbs: BusinessItemCategoryPresenter.new(business_item.category,
                                                     locale),
      thumb_url: repository.cover_photo_url_for(business_item,
                                                photos_repository, :thumb),
      created_at: business_item.created_at
    }
  end
end
