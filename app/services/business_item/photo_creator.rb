class BusinessItem::PhotoCreator
  takes :repository

  def perform(business_item, photo)
    attributes = repository.attributes_with_business_item({ photo: photo },
                                                          business_item)
    photo = repository.new(attributes)
    validator = BusinessItemPhotoValidator.new(attributes)
    handler = StoringHandler.new(photo, attributes, repository, validator)
    handler.perform
  end
end
