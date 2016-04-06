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

  def option_groups_from_collection_for_select2(collection, selected)
    collection.map do |group|
      option_groups(group, 0, selected)
    end.join.html_safe
  end

  def option_groups(group, level, selected)
    t = label_title(group.english_title, level)
    if group.children.count > 0
      array = []
      array << content_tag(:option, t, label: t, disabled: :disabled)
      group.children.each do |child|
        array << option_groups(child, level + 2, selected)
      end
      array.join('').html_safe
    else
      generate_child_option(t, group.id, selected)
    end
  end

  def generate_child_option(title, id, select)
    if id == select
      return content_tag(:option, title,
                  label: title,
                  value: id,
                  selected: :selected).html_safe
    else
      return content_tag(:option, title,
                  label: title,
                  value: id).html_safe
    end
  end

  def label_title(title, count)
    spacing = ['&nbsp;'].cycle(count).to_a.join(' ')
    (spacing + title).html_safe
  end
end
