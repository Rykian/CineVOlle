# Send a recap of next sessions by mail
class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@hostylez.com',
          reply_to: 'rykian@gmail.com'
  layout 'mailer'
end
