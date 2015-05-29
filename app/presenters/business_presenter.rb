class BusinessPresenter
  def options_for_business_types_select
    Business.business_types.map do |type, _|
      [I18n.t("business.types.#{type}"), type]
    end
  end
end
