class BusinessItem::Response < ::Response
  attr_accessor :object, :photos, :attributes

  def initialize(success: true, business_item: nil, attributes: nil, photos: nil)
    self.success = success
    self.object = business_item
    self.photos = photos
    self.attributes = attributes
  end
end
