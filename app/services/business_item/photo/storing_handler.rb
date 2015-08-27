class BusinessItem::Photo::StoringHandler < BusinessItem::BaseStoringHandler
  attr_reader :business_item, :handlers

  def initialize(repository, business_item, photos_params)
    @business_item = business_item
    @photos_params = photos_params

    repository.delete_other_than(business_item, photos_params.existing_ids)

    to_create = photos_params.new_files
    @handlers = to_create.map do |photo|
      BusinessItem::Photo::Creator.new(repository, business_item, photo)
    end
  end

  def valid?
    @photos_params.count > 0 && super
  end

  def object
    business_item
  end
end
