class BusinessStoringHandler < BaseService
  inject :business_repository

  attr_accessor :business, :storing_handler, :tags_storing_handler,
                :logo_storing_handler

  def initialize(business, business_params, tags_params, logo_params,
                 locale, validator, logo_validator)
    self.business = business
    self.storing_handler = StoringHandler.new(business, business_params,
                                              business_repository, validator)
    self.tags_storing_handler = TagsStoringHandler.new(business, tags_params,
                                                       locale)
    self.logo_storing_handler = LogoStoringHandler.new(business, logo_validator,
                                                       logo_params)
  end

  def perform
    success = [storing_handler,
               tags_storing_handler,
               logo_storing_handler].map(&:perform).all?(&:successful?)
    Response.new(success: success, object: business)
  end

  def valid?
    [storing_handler, logo_storing_handler].map(&:valid?).all?
  end
end
