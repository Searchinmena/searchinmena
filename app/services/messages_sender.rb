class MessagesSender
  takes :validator_factory

  def perform(business_id, user, subject, body)
    return ::Response.new(success: false) unless user

    business = Business.find_by_id(business_id)
    return ::Response.new(success: false) unless business

    validator = validator_factory.new(subject, body)
    if validator.valid?
      UserMailer.contact_seller(business.user, user, subject, body).deliver_now
      UserMailer.message_confirmation(business, user, subject, body).deliver_now
      ::Response.new(success: true)
    else
      ::Response.new(success: false, object: validator)
    end
  end
end
