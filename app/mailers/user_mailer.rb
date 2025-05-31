class UserMailer < ApplicationMailer
  default from: 'toru.stitch.626@gmail.com'

  def magic_link_email(email, magic_link)
    @magic_link = magic_link
    mail(to: email, subject: "ログイン用リンクのご案内")
  end
end
