class Registration::UserCreator < Registration::BaseCreator
  inject :user_repository
  attr_accessor :user

  def initialize(user, user_params)
    self.user = user
    self.validator = UserValidator.new(user_params)
    self.storing_handler = ::StoringHandler.new(
      user, user_params, user_repository, validator)
  end

  def copy_errors
    validator.copy_errors(user)
  end
end
