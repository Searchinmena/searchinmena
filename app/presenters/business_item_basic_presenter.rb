class BusinessItemBasicPresenter < BasePresenter
  takes :business_item, :repository

  def as_json(*)
    {
      id: business_item.id,
      name: business_item.name,
      breadcrumbs: BusinessItemCategoryPresenter.new(business_item.category),
      thumb_url: repository.photo_url_for(business_item, :thumb)
    }
  end
end
