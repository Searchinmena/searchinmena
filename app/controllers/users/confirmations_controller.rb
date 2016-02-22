module Users
  class ConfirmationsController < Devise::ConfirmationsController
    def create
      super do
        flash.now[:error] = full_error_message_for(resource)
      end
    end

    protected

    def after_resending_confirmation_instructions_path_for(_resource_name)
      Sim::Routes.dashboard_path
    end

    def after_confirmation_path_for(_resource_name, resource)
      CustomerIoService.new(resource, 'user_account_activate')
      Sim::Routes.dashboard_path
    end
  end
end
