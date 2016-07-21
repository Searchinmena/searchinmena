class InsightlyService::UserOpportunity < InsightlyService::InsightlyCreator
  def perform
    opportunity = @insightly.create_opportunity(opportunity:
                                                opportunity_params)
    inslightly_create('opportunity', opportunity.opportunity_id,
                      user.id, opportunity.opportunity_name)
  end

  def update
    type_id = find_insightly_type_id('opportunity')
    if type_id.present?
      @insightly.update_opportunity(opportunity: opportunity_params
                .merge!(opportunity_id: type_id))
    else
      perform
    end
  end

  def opportunity_category_id
    insightly_repository.find_by_name('Premium Subscription').type_id
  end

  def opportunity_params
    {
      opportunity_name: user.company_name,
      opportunity_state: 'OPEN',
      bid_currency: 'USD',
      bid_amount: 996,
      bid_type: 'Fixed Bid',
      opportunity_details: user.company_description,
      visible_to: 'EVERYONE',
      links: opportunity_links_params,
      responsible_user_id: A9n.insightly[:owner_user_id],
      category_id:  opportunity_category_id,
      stage_id: A9n.insightly[:pipeline_stage_id],
      pipeline_id: A9n.insightly[:pipeline_id]
    }
  end
end
