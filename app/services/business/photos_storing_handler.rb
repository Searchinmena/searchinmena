class Business::PhotosStoringHandler
  attr_accessor :business, :photos_params, :handlers

  def initialize(repository, business, photos_params)
    self.business = business
    self.photos_params = photos_params
    self.handlers = photos_params.map do |photo|
      Business::PhotoStoringHandler.new(repository, business, photo)
    end
  end

  def perform
    success = if valid?
      store
    else
      copy_errors
    end

    Response.new(success: success, object: object)
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

  def object
    business
  end

  def photos
    handlers.map(&:object)
  end
end
