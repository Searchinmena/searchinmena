module Users
  class PasswordsController < Devise::PasswordsController
    def create
      self.resource = resource_class
        .send_reset_password_instructions(resource_params)
      yield resource if block_given?

      if successfully_sent?(resource)
        respond_to_success
      else
        respond_to_error
      end
    end

    private

    def respond_to_success
      location = after_sending_reset_password_instructions_path_for(
        resource_name)
      respond_with({}, { location: location })
    end

    def respond_to_error
      flash[:error] = resource.errors.full_messages.first
      respond_with(resource)
    end
  end
end
