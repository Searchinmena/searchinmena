class InsightlyService::TaskCategory < InsightlyService::InsightlyCreator
  def perform
    # @user is category name here
    unless insightly_repository.find_by_name(@user).present?
      category = @insightly.create_task_category(category: category_params)
      inslightly_create('task_category', category.category_id, '',
                        category.category_name)
    end
  end

  def category_params
    {
      category_name: @user,
      background_color: 'ffff',
      active: true
    }
  end
end
