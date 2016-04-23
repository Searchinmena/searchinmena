module Users
  class SessionsController < Devise::SessionsController
    protected

    def after_sign_in_path_for(_resource)
      u = current_user
      CustomerIoService.new(u, 'user_just_login')
      session[:previous_url] || Sim::Routes.dashboard_path
    end
  end
end
