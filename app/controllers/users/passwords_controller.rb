module Users
  class PasswordsController < Devise::PasswordsController
    def create
      super do
        flash.now[:error] = full_error_message_for(resource)
      end
      if resource.reset_password_token.present?
        CustomerIoService.new(resource, 'reset_password_request')
      end
    end

    def update
      super do
        flash.now[:error] = full_error_message_for(resource)
      end
      if resource.id.present?
        CustomerIoService.new(resource, 'user_update_password')
      end
    end
  end
end
