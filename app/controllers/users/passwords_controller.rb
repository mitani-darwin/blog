# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:email)
  end
end
