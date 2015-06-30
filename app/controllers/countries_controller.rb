class CountriesController < TranslatableController
  inject :country_repository

  def repository
    country_repository
  end
end
