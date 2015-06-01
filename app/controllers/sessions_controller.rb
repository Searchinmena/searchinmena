class SessionsController < Devise::SessionsController
  after_action :email_confirmed?

  protected

  def after_sign_in_path_for(_resource)
    dashboard_path
  end
end
