class BusinessPresenter
  def options_for_business_types_select
    Business.business_types.map do |type, id|
      [I18n.t("business.types.#{type}"), id]
    end
  end
end
