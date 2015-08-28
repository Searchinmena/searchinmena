class BusinessItem::Photo::StoringHandler < BusinessItem::BaseStoringHandler
  attr_accessor :business_item, :handlers, :photos_params, :repository

  def initialize(repository, business_item, photos_params)
    self.business_item = business_item
    self.photos_params = photos_params
    self.repository = repository

    to_create = photos_params.new_files
    self.handlers = to_create.map do |photo|
      BusinessItem::Photo::Creator.new(repository, business_item, photo)
    end
  end

  def store
    repository.delete_other_than(business_item, photos_params.existing_ids)
    super
  end

  def valid?
    photos_params.count > 0 && super
  end

  def object
    business_item
  end
end
