class BaseBusinessSaver < BaseCreator
  attr_accessor :business, :user, :logo_validator

  def initialize(business, business_params, tags_params,
                 logo_params, locale, user)
    business_params.merge!(user: user)
    self.user = user
    self.business = business
    self.validator = BusinessValidator.new(business_params)
    self.logo_validator = LogoValidator.new(logo_params)
    self.storing_handler = BusinessStoringHandler.new(
      business, business_params, tags_params, logo_params,
      locale, validator, logo_validator)
  end

  def copy_errors
    logo_validator.copy_errors(business)
    validator.copy_errors(business)
  end

  def valid?
    logo_validator.valid? && validator.valid?
  end
end
