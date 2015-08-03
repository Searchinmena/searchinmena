class PaymentTermRepository < TranslatableRepository
  def for_business_item(business_item, locale)
    business_item.payment_terms.joins(:translations).includes(:translations)
      .where("translations.locale" => locale)
  end

  def attributes_with_business_item(attributes, business_item)
    attributes.merge(product: business_item)
  end
end
