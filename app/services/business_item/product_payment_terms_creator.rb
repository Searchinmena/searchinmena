class BusinessItem::ProductPaymentTermsCreator < BaseService
  inject :product_payment_term_repository

  takes :params, :business_item

  def perform
    creator = BusinessItem::PaymentTermsCreator.new(
      product_payment_term_repository, params, business_item)
    creator.perform
  end
end
