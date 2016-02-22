class CustomerIoService < Customerio::Client
  def initialize(parm, cio_event)
    @cio = Customerio::Client.new("#{A9n.cio[:id]}",
                                  "#{A9n.cio[:key]}", json: true)
    send cio_event, parm, cio_event
  end

  private

  def identify_user(parm)
    @cio.identify(
      id: parm.id,
      email: parm.email,
      created_at: parm.created_at.to_i,
      first_name: parm.first_name,
      last_name: parm.last_name,
      sign_in_count: parm.sign_in_count,
      category: parm.category
    )
  end

  def track_event(uid, cio_event, event_attributes = {})
    @cio.track(uid, cio_event, event_attributes)
  end

  def user_signup(parm, cio_event)
    identify_user(parm)
    track_event(parm.id, cio_event)
  end

  def user_just_login(parm, cio_event)
    identify_user(parm)
    track_event(parm.id, cio_event)
  end

  def user_updated_company(parm, cio_event)
    event_attributes = _company_info_attr(parm[:response])
    track_event(parm[:user].id, cio_event, event_attributes)
  end

  def user_completed_profile(parm, cio_event)
    user_updated_company(parm, cio_event)
  end

  def business_item_update(parm, cio_event)
    object = parm[:response].object
    product_attributes = _pro_serv_attr(object)
    attributes = _pro_serv_order_attr(object).merge!(product_attributes)
    event_attributes = _item_detail_attr(object).merge!(attributes)
    if object.updated_at.to_i == object.created_at.to_i
      cio_event = 'business_item_added'
    end
    track_event(parm[:user].id, cio_event, event_attributes)
  end

  def user_add_first_product(parm, cio_event)
    _first_business_item(parm, cio_event)
  end

  def user_add_first_service(parm, cio_event)
    _first_business_item(parm, cio_event)
  end

  def reset_password_request(parm, cio_event)
    identify_user(parm)
    event_attributes = {
      email: parm.email,
      reset_password_token: parm.reset_password_token
    }
    track_event(parm.id, cio_event, event_attributes)
  end

  def user_account_activate(parm, cio_event)
    identify_user(parm)
    track_event(parm.id, cio_event)
  end

  def user_update_password(parm, cio_event)
    identify_user(parm)
    track_event(parm.id, cio_event)
  end

  def message_company(parm, cio_event)
    params = parm[:params]
    user = parm[:user]
    business = Business.find_by_id(params[:business_id])
    event_attributes = _message_company_attr(params, user, business)
    track_event(user.id, cio_event, event_attributes)
  end

  def _first_business_item(parm, cio_event)
    object = parm[:response].object
    product_attributes = _pro_serv_attr(object)
    attributes = _pro_serv_order_attr(object).merge!(product_attributes)
    event_attributes = _item_detail_attr(object).merge!(attributes)
    if object.updated_at.to_i == object.created_at.to_i
      track_event(parm[:user].id, cio_event, event_attributes)
    end
  end

  def _company_info_attr(parm)
    {
      company_name: parm.name,
      #:company_category: ,
      company_phone_number: parm.phone,
      company_country: parm.country_id,
      company_city: parm.city,
      company_profile_pic: parm.logo,
      company_created_at: parm.created_at.to_i,
      company_updated_at: parm.updated_at.to_i,
      company_year_registered: parm.year_registered,
      company_no_of_employees: parm.no_of_employees,
      company_introduction: parm.introduction,
      company_address_line_1: parm.address_line_1,
      company_address_line_2: parm.address_line_2
    }
  end

  def _pro_serv_attr(parm)
    {
      product_id: parm.id,
      product_name: parm.name,
      created_at: parm.created_at.to_i,
      updated_at: parm.updated_at.to_i,
      description: parm.description,
      category_id: parm.category_id
    }
  end

  def _pro_serv_order_attr(parm)
    {
      fob_price: parm.fob_price,
      fob_price_currency_id: parm.fob_price_currency_id,
      fob_price_unit_id: parm.fob_price_unit_id,
      port: parm.port,
      supply_capacity: parm.supply_ability_capacity,
      supply_unit: parm.supply_ability_unit_id,
      supply_frequency: parm.supply_ability_frequency_id,
      packaging_details: parm.packaging_details,
      business_id: parm.business_id,
      characteristics_attr_name: _tags_attr(parm, ':name'),
      characteristics_attr_value: _tags_attr(parm, ':value')
    }
  end

  def _item_detail_attr(parm)
    {
      place_of_origin: _attr_exist(parm, ':place_of_origin'),
      scope_of_work: _attr_exist(parm, 'scope_of_work'),
      completion_time: _attr_exist(parm, 'average_completion_time'),
      completion_unit: _attr_exist(parm, 'average_completion_time_unit_id'),
      model_number: _attr_exist(parm, 'model_number'),
      brand_name: _attr_exist(parm, 'brand_name'),
      min_order: _attr_exist(parm, 'min_order_quantity_number'),
      min_order_unit: _attr_exist(parm, 'min_order_quantity_unit_id')
    }
  end

  def _tags_attr(parm, attr_name)
    if defined? parm.attributes
      _attr_exist(parm.attributes, attr_name)
    end
  end

  def _attr_exist(parm, attr_name)
    if parm.present?
      parm[attr_name].present? ? parm[attr_name] : nil
    end
  end

  def _message_company_attr(parm, user, business)
    {
      message_subject: parm[:subject],
      message_description: parm[:body],
      sender_email_address: user.email,
      sender_first_name: user.first_name,
      sender_last_name: user.last_name,
      recipient_company_name: business.name,
      recipient_company_logo: business.logo,
      recipient_email_address: business.user.email,
      recipient_first_name: business.user.first_name,
      recipient_last_name: business.user.last_name
    }
  end
end