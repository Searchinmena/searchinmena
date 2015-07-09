class BusinessItem::ServiceCreator < BaseService
  inject :service_repository

  takes :params, :user

  def perform
    creator = BusinessItem::Creator.new(
      service_repository, ServiceValidator,
      BusinessItem::ServiceAttributesCreator, params, user
    )
    creator.perform
  end
end

