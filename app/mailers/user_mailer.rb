class UserMailer < ApplicationMailer
  def contact_seller(seller, user, subject, body)
    @body = body
    mail(to: seller.email, from: user.email, subject: subject)
  end

  def message_confirmation(business, user, subject, body)
    @business = business
    @subject = subject
    @body = body

    subject = "Confirgmation of your message send to #{business.name}"
    mail(to: user.email, from: A9n.email_from, subject: subject)
  end
end
