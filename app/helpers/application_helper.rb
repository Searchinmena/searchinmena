module ApplicationHelper
  def dir
    :rtl if I18n.locale == :ar
  end

  def error_message_for(attribute)
    content_tag :span,
      "class" => "error",
      "ng-show" => "errors.#{attribute}" do
      "{{errors.#{attribute}}}"
    end
  end

  def form_field(attribute, &block)
    ng_class = "(errors.#{attribute}) ? 'field-with-errors' : ''"
    content_tag :div,
      "class" => "field",
      "ng-class" => ng_class do
      yield block
      concat(error_message_for(attribute))
    end
  end

  def current_year
    Time.now.year
  end
end
