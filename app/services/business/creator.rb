class Business::Creator < Business::BaseCreator
  attr_accessor :business

  def initialize(business, business_params, tags_params, locale, user)
    business_params.merge!(user: user)
    self.business = business
    self.validator = BusinessValidator.new(business_params)
    self.storing_handler = BusinessStoringHandler.new(
      business, business_params, tags_params, locale, validator)
  end

  def copy_errors
    validator.copy_errors(business)
  end
end
