class LogoValidator < FileValidator
  def self.fields
    []
  end

  attr_accessor(*fields)

  VALID_CONTENT_TYPES = %w{image/png image/jpeg image/gif}
  VALID_EXTENSIONS = %w{png jpg gif}

  validate :validate_minimum_image_size

  def initialize(logo_params = {})
    self.file = logo_params[:logo]
    super(logo_params)
  end

  def valid_content_types
    VALID_CONTENT_TYPES
  end

  def valid_extensions
    VALID_EXTENSIONS
  end

  def field(key)
    return :logo if key == :file

    super(key)
  end

  def validate_minimum_image_size
    image = MiniMagick::Image.open(file.path)
    if image[:width] < min_size || image[:height] < min_size
      errors.add(
        :file,
        I18n.t('errors.messages.invalid_size',
          min_width: min_size, min_height: min_size)
      )
    end
  end

  private

  def min_size
    A9n.validations[:min_logo_size]
  end
end
