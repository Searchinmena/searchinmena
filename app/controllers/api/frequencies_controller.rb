class Api::FrequenciesController < Api::TranslatableController
  inject :frequency_repository

  def repository
    frequency_repository
  end
end
