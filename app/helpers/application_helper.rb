module ApplicationHelper
  def dir
    :rtl if I18n.locale == :ar
  end

  def error_message_for(object, attribute)
    content_tag :span, class: 'error' do
      object.errors.messages[attribute.to_sym].try(:first)
    end
  end
end
