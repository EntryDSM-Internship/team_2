class AuthMailer < ApplicationMailer
  def send_auth_code(email, subject, auth_code)
    @auth_code = auth_code
    mail(to: email,
         subject: subject,
         from: 'wjd030811@gmail.com',
         content_type: 'text/html')
  end
end
