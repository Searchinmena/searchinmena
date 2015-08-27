class LogoStoringHandler < BaseService
  inject :business_repository
  takes :business, :logo_validator, :logo_params

  def perform
    success = if errors?
                copy_errors
                false
              else
                business.remove_logo! if !logo
                business.logo = logo
                business_repository.save(business)
                true
              end

    ::Response.new(success: success, object: logo)
  end

  def logo
    logo_params[:logo] if logo_params
  end

  def valid?
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
