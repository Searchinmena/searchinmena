class BaseBusinessSaver < BaseCreator
  attr_accessor :business, :tags_params, :business_params, :logo_params, :user,
                :logo_validator

  def initialize(business, business_params, tags_params,
                 logo_params, locale, user)
    business_params.merge!(user: user)
    self.user = user
    self.business = business
    self.tags_params = tags_params
    self.business_params = business_params
    self.logo_params = logo_params
    self.validator = BusinessValidator.new(business_params)
    self.logo_validator = LogoValidator.new(logo_params)
    self.storing_handler = BusinessStoringHandler.new(
      business, params, locale, validator, logo_validator
    )
  end

  def copy_errors
    logo_validator.copy_errors(business)
    validator.copy_errors(business)
  end

  def valid?
    storing_handler.valid?
  end

  private

  def params
    {
      business: business_params,
      tags: tags_params,
      logo: logo_params
    }
  end
end
