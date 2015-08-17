class UserCategoryService < BaseService
  attr_accessor :user_repository, :user, :business

  def initialize(user_repository, user, business = nil)
    self.user_repository = user_repository
    self.user = user
    self.business = business
  end

  def perform
    success = if user.buyer?
                user_repository.update_category(user, "both")
              else
                true
              end
    Response.new(success: success, object: business)
  end

  def valid?
    true
  end

  def copy_errors
  end
end
