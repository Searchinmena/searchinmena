class BusinessItem::Response < ::Response
  attr_accessor :photos, :attributes

  def initialize(success: true, business_item: nil, attributes: [], photos: [])
    self.success = success
    self.object = business_item
    self.photos = photos
    self.attributes = attributes
  end
end
