class InsightlyService::UserOpportunity < InsightlyService::InsightlyCreator
  def perform
    unless insightly_repository.find_by_name(@user.business.name).present?

      opportunity = @insightly.create_opportunity(opportunity:
                                                  opportunity_params)
      inslightly_create('opportunity', opportunity.opportunity_id,
                        @user.id, opportunity.opportunity_name)
    end
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

  def links_params
    contact_id = find_insightly_type_id('contact')
    organigasation_id = find_insightly_type_id('organisation')
    [{ contact_id: contact_id }, { organisation_id: organigasation_id }]
  end

  def opportunity_params
    {
      opportunity_name: user.company_name,
      opportunity_state: 'open',
      bind_currency: 996,
      opportunity_details: user.company_main_products,
      visible_to: 'EVERYONE',
      links: links_params
    }
  end
end
