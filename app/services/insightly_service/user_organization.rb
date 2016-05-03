class InsightlyService::UserOrganization < InsightlyService::InsightlyCreator
  def perform
    org = @insightly.create_organisation(organisation: org_params)
    inslightly_create('organisation', org.organisation_id, @user.id)
  end

  def update
    type_id = find_insightly_type_id('organisation')
    if type_id.present?
      @insightly.update_organisation(organisation: org_params
                                     .merge!(organisation_id: type_id))
    else
      perform
    end
  end

  def org_params
    {
      organisation_name: user.company_name,
      background: user.company_description,
      active: true,
      contactinfos: contact_infos,
      links: links_params

    }
  end
end
