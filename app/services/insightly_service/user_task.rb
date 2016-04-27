class InsightlyService::UserTask < InsightlyService::InsightlyCreator
  def perform
    titles = ["Telesales: Phone call", "Telesales: Introduction Email",
              "Telesales: Follow-up", "Telesales: Meeting",
              "Telesales: Quotation", "Telesales: Invoice"]

    attributes = task_params
    titles.each do |title|
      unless  @user.insightlies.where(name: title).present?
        attributes[:title] = title
        task = @insightly.create_task(task: attributes)
        inslightly_create('task', task.task_id, @user.id, title)
      end
    end
  end

  def add_links
    contact_id =  find_insightly_type_id('contact')
    organisation_id =  find_insightly_type_id('organisation')
    opportunity_id = find_insightly_type_id('opportunity')

    [{ organisation_id: organisation_id }, { contact_id: contact_id },
     { opportunity_id: opportunity_id }]
  end

  def task_params
    {
      title: '', publicly_visible: true,
      completed: false, owner_user_id: A9n.insightly[:owner_user_id],
      responsible_user_id: A9n.insightly[:owner_user_id],
      tasklinks: add_links
    }
  end
end
