class BusinessStoringHandler < BaseService
  inject :business_repository

  attr_accessor :storing_handler, :tags_storing_handler, :business

  def initialize(business, business_params, tags_params, locale, validator)
    self.business = business
    self.storing_handler = StoringHandler.new(business, business_params,
                                              business_repository, validator)
    self.tags_storing_handler = TagsStoringHandler.new(business, tags_params,
                                                       locale)
  end

  def perform
    success = [storing_handler,
               tags_storing_handler].map(&:perform).all?(&:successful?)
    Response.new(success: success, object: business)
  end
end
