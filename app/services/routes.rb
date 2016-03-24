class Routes
  include Rails.application.routes.url_helpers

  def dashboard_path
    "/dashboard"
  end

  def browse_path
    "/browse"
  end

  def business_show_path
    "/company/"
  end

  def product_show_path
    "/products/"
  end

  def service_show_path
    "/services/"
  end
end
