class Business::Saver < BaseService
  attr_accessor :handlers, :business, :photos

  def initialize(handlers, business, photos)
    self.handlers = handlers
    self.business = business
    self.photos = photos
  end

  def perform
    success = if valid?
      store
    else
      copy_errors
    end

    Business::BusinessResponse.new(success: success,
                                   business: business,
                                   photos: photos)
  end

  def valid?
    handlers.map(&:valid?).all?
  end

  def store
    handlers.map(&:perform).all?(&:successful?)
  end

  def copy_errors
    handlers.each(&:copy_errors)
    false
  end
end
