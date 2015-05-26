module ApplicationHelper
  def dir
    :rtl if I18n.locale == :ar
  end
end
