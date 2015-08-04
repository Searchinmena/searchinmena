class PhotoValidator < FileValidator
  VALID_CONTENT_TYPES = %w{image/png image/jpeg}
  VALID_EXTENSIONS = %w{png jpg}

  validate :validate_minimum_image_size

  def initialize(record_params = {}, file_error_key = :file)
    self.file = record_params[:photo]
    super(record_params, file_error_key)
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

  def validate_minimum_image_size
    image = MiniMagick::Image.open(file.path)
    if image[:width] < min_width || image[:height] < min_height
      errors.add(
        :file,
        I18n.t('errors.messages.invalid_size',
              min_width: min_width, min_height: min_height)
      )
    end
  end

  private

  def min_width
    A9n.validations[:min_image_width]
  end

  def min_height
    A9n.validations[:min_image_height]
  end
end
