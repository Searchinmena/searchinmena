class BusinessItem::PaymentTerms::Creator
  takes :repository, :params, :business_item

  def perform
    responses = params.map do |payment_term_id|
      payment_terms_params = repository.attributes_with_business_item(
        { payment_term_id: payment_term_id },
        business_item
      )
      payment_term = repository.new(payment_terms_params)
      validator = PaymentTermValidator.new(payment_terms_params)
      storing_handler = ::StoringHandler.new(payment_term,
                                           payment_terms_params,
                                           repository,
                                           validator)
      storing_handler.perform
    end
    Response.new(success: responses.all?(&:successful?), object: business_item)
  end
end
