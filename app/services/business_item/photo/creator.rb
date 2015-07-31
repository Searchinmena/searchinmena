class BusinessItem::Photo::Creator < BaseCreator
  attr_accessor :product_photo_repository, :photo

  def initialize(business_item, photo)
    self.product_photo_repository = ProductPhotoRepository.new
    attributes = product_photo_repository.attributes_with_business_item({ photo: photo },
                                                                        business_item)
    self.photo = product_photo_repository.new(attributes)
    self.validator = BusinessItemPhotoValidator.new(attributes)
    self.storing_handler = ::StoringHandler.new(photo, attributes, product_photo_repository, validator)
  end

  def perform
    validate
    success = if errors?
                copy_errors
                false
              else
                product_photo_repository.save(photo)
                true
              end
    ::Response.new(success: success, object: photo)
  end

  def validate
    validator.valid?
  end

  def errors?
    validator.errors?
  end

  def copy_errors
    validator.copy_errors(photo)
  end

  def object
    photo
  end
end
