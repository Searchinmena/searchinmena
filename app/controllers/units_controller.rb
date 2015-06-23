class UnitsController < TranslatableController
  inject :unit_repository

  def repository
    unit_repository
  end
end
