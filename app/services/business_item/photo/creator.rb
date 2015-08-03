class BusinessItem::Photo::Creator < BaseCreator
  attr_accessor :repository, :photo

  def initialize(repository, business_item, photo)
    self.repository = repository
    attributes = repository.attributes_with_business_item({ photo: photo },
                                                                        business_item)
    self.photo = repository.new(attributes)
    self.validator = BusinessItemPhotoValidator.new(attributes)
    self.storing_handler = ::StoringHandler.new(photo, attributes, repository, validator)
  end

  def perform
    validate
    success = if errors?
                copy_errors
                false
              else
                repository.save(photo)
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
