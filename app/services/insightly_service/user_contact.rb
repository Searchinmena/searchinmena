class InsightlyService::UserContact < InsightlyService::InsightlyCreator
  def perform
    contact = @insightly.create_contact(contact: user_contact_params)
    inslightly_create('contact', contact.contact_id, @user.id)
  end

  def update
    contact_id = find_insightly_type_id('contact')
    if contact_id.present?
      @insightly.update_contact(contact: user_contact_params
                .merge!(user_contact(contact_id)))
    else
      perform
    end
  end

  def user_contact(contact_id)
    { contact_id: contact_id }
  end

  def user_contact_params
    {
      first_name: @user.first_name,
      last_name: @user.last_name,
      contactinfos: contact_infos,
      date_created_utc:  @user.created_at.strftime("%Y-%m-%d %H:%M:%S")
    }
  end
end
