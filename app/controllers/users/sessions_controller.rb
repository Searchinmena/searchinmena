module Users
  class SessionsController < Devise::SessionsController
    inject :customer_io_service

    protected

    def after_sign_in_path_for(_resource)
      u = current_user
      customer_io_service.cio('user_just_login', u)
      Sim::Routes.dashboard_path
    end
  end
end
