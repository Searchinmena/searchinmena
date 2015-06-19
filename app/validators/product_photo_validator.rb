class ProductPhotoValidator < BaseValidator
  def self.fields
    []
  end

  attr_accessor(*fields)
end
