class RegistrationsController < Devise::RegistrationsController
  def new
    @business_presenter = BusinessPresenter.new
    super
  end
end
