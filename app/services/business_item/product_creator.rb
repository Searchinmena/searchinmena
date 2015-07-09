class BusinessItem::ProductCreator < BaseService
  inject :product_repository

  takes :params, :user

  def perform
    creator = BusinessItem::Creator.new(
      product_repository, ProductValidator,
      BusinessItem::ProductAttributesCreator,
      BusinessItem::ProductPaymentTermsCreator,
      params, user
    )
    creator.perform
  end
end

