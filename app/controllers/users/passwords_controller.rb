module Users
  class PasswordsController < Devise::PasswordsController
    def create
      super do
        flash.now[:error] = full_error_message_for(resource)
      end
    end
  end
end
