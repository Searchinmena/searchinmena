class Routes
  include Rails.application.routes.url_helpers

  def dashboard_path
    "/#/dashboard"
  end

  def browse_path
    "/#/browse"
  end
end
