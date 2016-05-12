class UserMailer < ApplicationMailer
  def contact_seller(seller, subject, body)
    @body = body
    mail(to: seller.email, from: A9n.email_from, subject: subject)
  end

  def message_confirmation(business, user, subject, body)
    @business = business
    @subject = subject
    @body = body

    subject = "You have sent a message to #{business.name}"
    mail(to: user.email, bcc: A9n.email_bcc,
         from: A9n.email_from, subject: subject)
  end
end
