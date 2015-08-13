class UserMailer < ApplicationMailer
  def contact_seller(seller, user, subject, body)
    @body = body
    mail(to: seller.email, from: user.email, subject: subject)
  end
end
