class PaymentTermPresenter
  takes :payment_term

  def as_json(*)
    payment_term.translations.first.value
  end
end
