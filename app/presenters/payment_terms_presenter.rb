class PaymentTermsPresenter < BasePresenter
  inject :payment_term_repository

  takes :business_item, :locale

  def as_json(*)
    terms = payment_term_repository.for_business_item(business_item, locale)

    {
      names: payment_terms_names(terms),
      ids: payment_terms_ids(terms)
    }
  end

  def payment_terms_ids(terms)
    pairs = terms.map do |pt|
      [pt.id, true]
    end
    Hash[pairs]
  end

  def payment_terms_names(terms)
    terms.map do |pt|
      pt.translations.first.value
    end
  end
end
