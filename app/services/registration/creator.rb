class Registration::Creator < BaseService
  inject :user_repository, :business_repository, :storer_factory

  attr_accessor :storer, :user, :business

  def initialize(registration_params)
    self.business = business_repository.new(registration_params[:business])
    self.user = user_repository.new(registration_params[:user])

    category = registration_params[:user][:category]
    records = { user: user, business: business }
    self.storer = storer_factory.from_category(category, records,
                                               registration_params)
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
