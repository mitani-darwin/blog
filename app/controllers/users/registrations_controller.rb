# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  Devise::RegistrationsController
  private

  # strong_parametersからパスワードを削除する
  def sign_up_params
    params.require(:user).permit(:email)
  end

  def account_update_params
    params.require(:user).permit(:email)
  end
end
