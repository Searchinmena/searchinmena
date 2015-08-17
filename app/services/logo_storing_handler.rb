class LogoStoringHandler < BaseService
  inject :business_repository
  takes :business, :logo_validator, :logo_params

  def perform
    return ::Response.new(success: true, object: logo) if logo.blank?

    validate
    success = if errors?
                copy_errors
                false
              else
                business.logo = logo
                business_repository.save(business)
                true
              end

    ::Response.new(success: success, object: logo)
  end

  def logo
    logo_params[:logo]
  end

  def validate
    logo_validator.valid?
  end

  def errors?
    logo_validator.errors?
  end

  def copy_errors
    logo_validator.copy_errors(business)
  end

  def object
    logo
  end
end
