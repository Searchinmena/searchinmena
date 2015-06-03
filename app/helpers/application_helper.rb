module ApplicationHelper
  def dir
    :rtl if I18n.locale == :ar
  end

  def email_confirmed?
    current_user && current_user.confirmed_at.present?
  end

  def error_message_for(object, attribute)
    if object.errors.any?
      content_tag :span, class: 'error' do
        object.errors.messages[attribute.to_sym].try(:first)
      end
    end
  end
end
