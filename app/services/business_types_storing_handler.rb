class BusinessTypesStoringHandler < BaseService
  inject :business_type_repository, :business_repository

  takes :business, :business_types_params

  def perform
    success = business_types_params.each do |business_type_id|
      business_type = business_type_repository.find_by_id(business_type_id)
      business_repository.add_business_type(business, business_type)
    end.all?
    Response.new(success: success)
  end
end
