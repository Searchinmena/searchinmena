class DevisePresenter
  def self.login_link?(controller_name)
    controller_name != 'sessions'
  end

  def self.registrations_link?(devise_mapping, controller_name)
    devise_mapping.registerable? && controller_name != 'registrations'
  end

  def self.forgot_your_password_link?(devise_mapping, controller_name)
    devise_mapping.recoverable? && controller_name != 'passwords'
  end

  def self.confirmation_link?(controller_name, devise_mapping)
    devise_mapping.confirmable? && controller_name != 'confirmations'
  end

  def self.unlock_instructions_link?(devise_mapping,
                                     controller_name, resource_class)
    devise_mapping.lockable? &&
      resource_class.unlock_strategy_enabled?(:email) &&
      controller_name != 'unlocks'
  end
end

