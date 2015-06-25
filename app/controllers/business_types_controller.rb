class BusinessTypesController < TranslatableController
  inject :business_type_repository

  def repository
    business_type_repository
  end
end
