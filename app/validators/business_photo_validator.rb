class BusinessPhotoValidator < PhotoValidator
  def self.fields
    []
  end

  attr_accessor(*fields)
end
