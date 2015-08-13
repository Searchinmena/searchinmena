class FileValidator < BaseValidator
  MAX_FILE_SIZE_IN_MB = A9n.validations[:max_file_size_in_mb]
  validate :check_content_type, :file_size

  attr_accessor :file, :file_error_key

  def initialize(record_params = {}, file_error_key = :file)
    @file_error_key = file_error_key
    super(record_params)
  end

  def valid_content_types
    fail NotImplementedError
  end

  def check_content_type
    if file.present? && !valid_content_type?(file)
      errors.add(
        file_error_key,
        I18n.t('errors.messages.invalid_content_type',
              types: valid_extensions.join(", "))
      )
    end
  end

  def valid_content_type?(file)
    return unless file

    valid_content_types.include?(file.content_type)
  end

  def file_size
    if file.present? && file.size.to_f > MAX_FILE_SIZE_IN_MB.megabytes
      errors.add(file_error_key,
                 I18n.t('errors.messages.file_too_large',
                        max_file_size_in_mb: MAX_FILE_SIZE_IN_MB))
    end
  end
end
