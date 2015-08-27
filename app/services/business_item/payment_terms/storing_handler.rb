class BusinessItem::PaymentTerms::StoringHandler
  takes :repository, :params, :business_item

  def perform
    to_create = to_create(params)
    responses = to_create.map do |payment_term_id|
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

  def to_create(params)
    repository.delete_other_than(business_item, params)
    params.reject { |id| exising_ids.include?(id.to_i) }
  end

  def exising_ids
    repository.for_business_item(business_item).map(&:payment_term_id)
  end

  def valid?
    true
  end

  def copy_errors
  end
end
