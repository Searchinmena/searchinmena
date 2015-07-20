class PaymentTermRepository < TranslatableRepository
  def for_business_item(business_item, locale)
    business_item.payment_terms.joins(:translations).includes(:translations)
      .where("translations.locale" => locale)
  end
end
