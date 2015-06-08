class Registration::Creator < BaseService
  inject :user_repository, :business_repository, :storer_factory

  takes :registration_params

  def perform
    business = business_repository.new(registration_params[:business])
    user = user_repository.new(registration_params[:user])

    category = registration_params[:user][:category]
    records = { user: user, business: business }
    storer = storer_factory.from_category(category, records,
                                               registration_params)
    storer.perform(user, business)
  end
end
