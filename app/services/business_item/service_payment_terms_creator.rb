class BusinessItem::ServicePaymentTermsCreator < BaseService
  inject :service_payment_term_repository

  takes :params, :business_item

  def perform
    creator = BusinessItem::PaymentTermsCreator.new(
      service_payment_term_repository, params, business_item)
    creator.perform
  end
end
