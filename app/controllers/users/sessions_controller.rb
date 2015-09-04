module Users
  class SessionsController < Devise::SessionsController
    protected

    def after_sign_in_path_for(_resource)
      Sim::Routes.dashboard_path
    end
  end
end
