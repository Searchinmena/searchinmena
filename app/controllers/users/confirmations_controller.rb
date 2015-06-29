module Users
  class ConfirmationsController < Devise::ConfirmationsController
    def create
      super do
        flash[:error] = full_error_message_for(resource)
      end
    end

    protected

    def after_resending_confirmation_instructions_path_for(_resource_name)
      dashboard_path
    end
  end
end
