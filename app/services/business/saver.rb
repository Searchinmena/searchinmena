class Business::Saver < BaseService
  takes :base_business_saver, :user_category_service

  def perform(user)
    response = base_business_saver.perform
    return response unless response.successful?

    user_category_service.perform(user)
  end
end
