class BusinessItemCategoryPresenter < BasePresenter
  inject :category_repository

  takes :category, :locale

  def as_json(*)
    category_repository.hierarchy_for(category).map do |c|
      {
        id: c.id,
        name: category_repository.translation_for(c, locale),
        meta_title: c.meta_title
        # meta_keywords: c.meta_keywords,
        # meta_description: c.meta_description
      }
    end
  end
end
