class Registration::Creator < BaseService
  inject :user_repository, :business_repository

  attr_accessor :storer, :user, :business

  def initialize(user_params, business_params)
    self.business = business_repository.new(business_params)
    self.user = user_repository.setup(user_params)

    category = user_params[:category]
    self.storer = Registration::Storer.from_category(
      category, user, user_params, business, business_params)
  end

  def perform
    success = if storer.valid?
                storer.store
              else
                storer.copy_errors
              end

    Registration::Response.new(
      success: success, user: user, business: business)
  end
end
