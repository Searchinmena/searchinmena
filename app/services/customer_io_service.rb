class CustomerIoService
  def cio(cio_event, parm)
    send cio_event, cio_event, parm
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

  def user_signup(cio_event, parm)
    identify_user(parm)
    @cio.track(parm.id, cio_event)
  end

  def user_just_login(cio_event, parm)
    identify_user(parm)
    @cio.track(parm.id, cio_event)
  end

  def user_updated_company(cio_event, parm)
    company_info_track(cio_event, parm)
  end

  def user_add_company(cio_event, parm)
    company_info_track(cio_event, parm)
  end

  def company_info_track(cio_event, parm)
    @cio.track(
      parm.user_id,
      cio_event,
      company_id: parm.id,
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
    )
  end

  def user_add_product(cio_event, p)
    object = is_object_exist(p['response'].object)
    uid = p['user'].id
    attributes = attribute_exist(p['response'])
    user_add_product_track(uid, cio_event, object, attributes)
  end

  def attribute_exist(response)
    if response.attributes.present?
      parm_attr = response.attributes.first
      attributes = { name: parm_attr['name'], value: parm_attr['value'] }
    else
      attributes = { name: '', value: '' }
    end
    attributes
  end

  def user_add_product_track(uid, cio_event, parm, attributes)
    @cio.track(
      uid, cio_event,
      product_id: parm.id,
      company_name: parm.name,
      model_number: parm.model_number,
      brand_name: parm.brand_name,
      description: parm.description,
      category_id: parm.category_id,
      created_at: parm.created_at.to_i,
      updated_at: parm.updated_at.to_i,
      characteristics_attr_name: attributes['name'],
      characteristics_attr_value: attributes['value']
    )
  end
end