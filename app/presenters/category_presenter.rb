class CategoryPresenter
  takes :category

  def as_json(*)
    {
      id: category.id,
      name: category.translations.first.value,
      parent_id: category.parent_id
    }
  end
end
