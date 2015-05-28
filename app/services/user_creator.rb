class UserCreator
  takes :user_repository, :business_repository, :user_params, :business_params

  attr_accessor :user, :business, :user_validator, :business_validator,
                :validators

  def initialize(user_repository, business_repository,
                 user_params, business_params)
    super

    self.user_validator = UserValidator.new(user_params)
    self.business_validator = BusinessValidator.new(business_params)

    self.validators = [user_validator, business_validator]

    self.business = business_repository.new(business_params)
    self.user = user_repository.new(user_params)
  end

  def perform
    success = if all_validation_passing?
                store_all
              else
                copy_errors
              end

    UserCreatorResponse.new(success: success, user: user, business: business)
  end

  private

  def all_validation_passing?
    validators.map(&:valid?).all?
  end

  def store_all
    store_user
    store_business
  end

  def store_user
    store(user, user_params, user_repository, user_validator)
  end

  def store_business
    business_params.merge!(user: user)
    store(business, business_params, business_repository, business_validator)
  end

  def store(record, record_params, repository, validator)
    handler = StoringHandler.new(record, record_params, repository, validator)
    handler.perform
  end

  def copy_errors
    user_validator.copy_errors(user)
    business_validator.copy_errors(business)
    false
  end
end
