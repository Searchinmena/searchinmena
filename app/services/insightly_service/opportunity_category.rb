class InsightlyService::OpportunityCategory < InsightlyService::InsightlyCreator
  def perform
    name = insightly_repository.find_by_name('Premium Subscription').present?
    unless name
      category = @insightly.create_opportunity_category(category:
                                                         category_prams)

      inslightly_create('opportunity_category',
                         category.category_id, '', 'Premium Subscription')
    end
  end

  def category_prams
    {
      category_name: 'Premium Subscription',
      active: true,
      background_color: "4e469f"
    }
  end
end
