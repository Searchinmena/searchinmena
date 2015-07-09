class BusinessItemBasicPresenter < BasePresenter
  inject :product_repository

  takes :business_item

  def as_json(*)
    {
      id: business_item.id,
      name: business_item.name,
      breadcrumbs: BusinessItemCategoryPresenter.new(business_item.category),
      thumb_url: product_repository.photo_url_for(business_item, :thumb)
    }
  end
end
