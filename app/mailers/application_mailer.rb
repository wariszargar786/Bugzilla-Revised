class ApplicationMailer < ActionMailer::Base
  default from: 'info@bugzilla.com'
  layout 'mailer'
end
