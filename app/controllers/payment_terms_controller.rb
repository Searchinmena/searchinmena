class PaymentTermsController < TranslatableController
  inject :payment_term_repository

  def repository
    payment_term_repository
  end
end
