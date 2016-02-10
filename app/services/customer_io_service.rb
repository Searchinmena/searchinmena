class CustomerIoService < Customerio::Client
  def initialize(parm, cio_event)
    @cio = Customerio::Client.new("3823999354dd63de1f8d",
                                  "1a4d2164782635ea53b1", json: true)
    send cio_event, parm, cio_event
  end

  def cio(parm, cio_event)
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
    event_attributes = company_info_attr(parm[:response])
    if parm[:response].updated_at.to_i == parm[:response].created_at.to_i
      cio_event = 'user_add_company'
    end
    track_event(parm[:user].id, cio_event, event_attributes)
  end

  def company_info_attr(parm)
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

  def user_update_product(parm, cio_event)
    product_attributes = pro_serv_attr(parm[:response])
    order_attributes = pro_serv_order_attr(parm)
    event_attributes = product_attributes.merge!(order_attributes)
    if parm[:response].updated_at.to_i == parm[:response].created_at.to_i
      cio_event = 'user_add_product'
    end
    track_event(parm[:user].id, cio_event, event_attributes)
  end

  def pro_serv_attr(parm)
    {
      product_id: parm.id,
      product_name: parm.name,
      model_number: parm.model_number,
      brand_name: parm.brand_name,
      description: parm.description,
      category_id: parm.category_id,
      created_at: parm.created_at.to_i,
      updated_at: parm.updated_at.to_i
    }
  end

  def pro_serv_order_attr(parm)
    {
      min_order: attribute_exist(parm, ':min_order_quantity_number'),
      min_order_unit: attribute_exist(parm, ':min_order_quantity_unit_id'),
      fob_price: attribute_exist(parm, ':fob_price'),
      fob_price_currency_id: attribute_exist(parm, ':fob_price_currency_id'),
      fob_price_unit_id: attribute_exist(parm, ':fob_price_unit_id'),
      port: attribute_exist(parm, ':port'),
      supply_capacity: attribute_exist(parm, ':supply_ability_capacity'),
      supply_unit: attribute_exist(parm, ':supply_ability_unit_id'),
      supply_frequency: attribute_exist(parm, ':supply_ability_frequency_id'),
      packaging_details: attribute_exist(parm, ':packaging_details'),
      business_id: attribute_exist(parm, ':business_id'),
      characteristics_attr_name: tags_attr(parm, ':name'),
      characteristics_attr_value: tags_attr(parm, ':value')
    }
  end

  def attribute_exist(parm, attr_name)
    if parm.present?
      parm[attr_name].present? ? parm[attr_name] : nil
    end
  end

  def tags_attr(parm, attr_name)
    if defined? parm.attributes
      attribute_exist(parm.attributes, attr_name)
    end
  end
end