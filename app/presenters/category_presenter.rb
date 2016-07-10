class CategoryPresenter
  takes :category
  require 'uri'

  def as_json(*)
    {
      id: category.id,
      name: category.translations.first.value,
      parent_id: category.parent_id,
      path: ERB::Util.url_encode(category.translations.first.value)
    }
  end
end
