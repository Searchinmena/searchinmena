module Users
  class ConfirmationsController < Devise::ConfirmationsController
    protected

    def after_resending_confirmation_instructions_path_for(_resource_name)
      dashboard_path
    end
  end
end
