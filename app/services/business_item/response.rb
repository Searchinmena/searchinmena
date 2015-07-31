class BusinessItem::Response < ::Response
  attr_accessor :product, :photos, :attributes

  def initialize(success: true, product: nil, photos: nil, attributes: nil)
    self.success = success
    self.product = product
    self.photos = photos
    self.attributes = attributes
  end
end
