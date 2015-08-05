class BusinessItem::Photo::StoringHandler < BusinessItem::BaseStoringHandler
  attr_reader :busiess_item, :handlers

  def initialize(repository, busiess_item, photos_params)
    @busiess_item = busiess_item
    @photos_params = photos_params
    @handlers = photos_params.map do |photo|
      BusinessItem::Photo::Creator.new(repository, busiess_item, photo)
    end
  end

  def valid?
    @photos_params.any? && super
  end

  def object
    busiess_item
  end
end
