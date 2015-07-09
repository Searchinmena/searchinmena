class BusinessItemCategoryPresenter < BasePresenter
  inject :category_repository

  takes :category

  def as_json(*)
    category_repository.hierarchy_for(category).map do |c|
      { id: c.id, name: category_repository.translation_for(c) }
    end
  end
end
