class BusinessItem::Response < ::Response
  attr_accessor :object, :photos, :attributes

  def initialize(success: true, product: nil, attributes: nil, photos: nil)
    self.success = success
    self.object = product
    self.photos = photos
    self.attributes = attributes
  end
end
