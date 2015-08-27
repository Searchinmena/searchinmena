class BusinessItem::Photo::StoringHandler < BusinessItem::BaseStoringHandler
  attr_reader :busiess_item, :handlers

  def initialize(repository, busiess_item, photos_params)
    @busiess_item = busiess_item
    @photos_params = photos_params

    repository.delete_other_than(busiess_item, photos_params.existing_ids)

    to_create = photos_params.new_files
    @handlers = to_create.map do |photo|
      BusinessItem::Photo::Creator.new(repository, busiess_item, photo)
    end
  end

  def valid?
    @photos_params.count > 0 && super
  end

  def object
    busiess_item
  end
end
