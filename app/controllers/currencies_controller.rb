class CurrenciesController < TranslatableController
  inject :currency_repository

  def repository
    currency_repository
  end
end
