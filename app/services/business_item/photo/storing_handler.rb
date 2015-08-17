class BusinessItem::Photo::StoringHandler < BusinessItem::BaseStoringHandler
  attr_reader :business_item, :handlers

  def initialize(repository, business_item, photos_params)
    @business_item = business_item
    @photos_params = photos_params
    @handlers = photos_params.map do |photo|
      BusinessItem::Photo::Creator.new(repository, business_item, photo)
    end
  end

  def valid?
    @photos_params.any? && super
  end

  def object
    business_item
  end
end
