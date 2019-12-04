class AuthMailer < ApplicationMailer
  def send_auth_code(email, auth_code)
    @auth_code = auth_code
    mail(to: email,
         subject: 'MINITWEEET에서 인증번호가 도착했습니다.',
         from: 'wjd030811@gmail.com',
         content_type: 'text/html')
  end
end
