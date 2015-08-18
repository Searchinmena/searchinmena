class ApplicationMailer < ActionMailer::Base
  default from: A9n.email_from
  layout 'mailer'
  add_template_helper(ApplicationHelper)
end
