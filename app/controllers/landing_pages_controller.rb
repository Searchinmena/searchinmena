class LandingPagesController < ApplicationController
  inject :user_repository, :business_repository, :user_params_factory
  skip_before_filter :authenticate_user!
  def home_one
    user_params = user_params_factory.build(session["devise.auth_data"])
    user = user_repository.new(user_params)
    business = business_repository.new
    session["devise.auth_data"] = nil
    render :home_one, locals:
       {
         user: user, business: business,
         user_presenter: UserPresenter.new(user)

       }
  end
end
