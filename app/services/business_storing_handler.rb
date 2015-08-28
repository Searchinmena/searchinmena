class BusinessStoringHandler < BaseService
  inject :business_repository

  attr_accessor :business, :storing_handler, :tags_storing_handler,
                :logo_storing_handler

  def initialize(business, params, locale, validator, logo_validator)
    self.business = business
    self.storing_handler = StoringHandler.new(business, params[:business],
                                              business_repository, validator)
    self.tags_storing_handler = TagsStoringHandler.new(business, params[:tags],
                                                       locale)
    self.logo_storing_handler = LogoStoringHandler.new(business, logo_validator,
                                                       params[:logo])
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
