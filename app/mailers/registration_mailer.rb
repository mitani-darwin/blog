# frozen_string_literal: true

class RegistrationMailer < ApplicationMailer
  default from: 'no-reply@yourdomain.com'

  # 新規登録の招待メール
  def new_registration_invitation(email)
    @signup_url = new_user_registration_url

    mail(to: email, subject: "新規登録のご案内")
  end
end