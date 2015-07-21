class UserCategoryService < BaseService
  takes :user_repository

  def perform(user, business)
    success = if user.buyer?
                user_repository.update_category(user, "both")
              else
                true
              end
    Response.new(success: success, object: business)
  end
end
