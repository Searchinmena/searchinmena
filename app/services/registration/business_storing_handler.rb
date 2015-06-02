class Registration::BusinessStoringHandler < Registration::StoringHandler
  inject :business_repository
  attr_accessor :business

  def initialize(business, business_params, user)
    business_params.merge!(user: user)
    self.business = business
    self.validator = BusinessValidator.new(business_params)
    self.storing_handler = ::StoringHandler.new(
      business, business_params, business_repository, validator)
  end

  def copy_errors
    validator.copy_errors(business)
  end
end
