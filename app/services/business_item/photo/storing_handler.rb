class BusinessItem::Photo::StoringHandler < BusinessItem::BaseStoringHandler
  attr_accessor :busiess_item, :handlers, :photos_params, :repository

  def initialize(repository, busiess_item, photos_params)
    self.busiess_item = busiess_item
    self.photos_params = photos_params
    self.repository = repository

    to_create = photos_params.new_files
    self.handlers = to_create.map do |photo|
      BusinessItem::Photo::Creator.new(repository, busiess_item, photo)
    end
  end

  def store
    repository.delete_other_than(busiess_item, photos_params.existing_ids)
    super
  end

  def valid?
    photos_params.count > 0 && super
  end

  def object
    busiess_item
  end
end
