class Api::CurrenciesController < Api::TranslatableController
  inject :currency_repository

  def repository
    currency_repository
  end
end
