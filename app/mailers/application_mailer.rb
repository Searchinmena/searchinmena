class ApplicationMailer < ActionMailer::Base
  default from: A9n.email_from
  layout 'mailer'
end
