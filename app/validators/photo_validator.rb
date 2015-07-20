class PhotoValidator < FileValidator
  VALID_CONTENT_TYPES = %w{image/png image/jpeg}
  VALID_EXTENSIONS = %w{png jpg}

  def initialize(record_params = {})
    self.file = record_params[:photo]
    super(record_params)
  end

  def valid_content_types
    VALID_CONTENT_TYPES
  end

  def valid_extensions
    PhotoValidator::VALID_EXTENSIONS
  end

  def field(key)
    return :photo if key == :file

    super(key)
  end
end

