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
    "/product/"
  end

  def service_show_path
    "/service/"
  end

  def product_category_path
    "/results?type=product&query="
  end

  def service_category_path
    "/results?type=service&query="
  end
end
