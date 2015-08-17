class Business::BusinessResponse < ::Response
  attr_accessor :photos

  def initialize(success: true, business: nil, photos: [])
    self.success = success
    self.object = business
    self.photos = photos
  end
end
