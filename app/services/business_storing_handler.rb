class BusinessStoringHandler < BaseService
  inject :business_repository

  attr_accessor :storing_handler, :tags_storing_handler

  def initialize(business, business_params, tags_params, validator)
    self.storing_handler = StoringHandler.new(business, business_params,
                                              business_repository, validator)
    self.tags_storing_handler = TagsStoringHandler.new(business, tags_params)
  end

  def perform
    success = [storing_handler,
               tags_storing_handler].map(&:perform).all?
    Response.new(success: success)
  end
end
